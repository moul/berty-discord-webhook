package main

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"math/rand"
	"os"
	"runtime"
	"syscall"

	"berty.tech/berty/v2/go/pkg/bertybot"
	"berty.tech/berty/v2/go/pkg/bertyversion"
	"berty.tech/berty/v2/go/pkg/messengertypes"
	"github.com/gtuk/discordwebhook"
	qrterminal "github.com/mdp/qrterminal/v3"
	"github.com/oklog/run"
	"github.com/peterbourgon/ff/v3"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"google.golang.org/grpc"
	"moul.io/climan"
	"moul.io/motd"
	"moul.io/srand"
	"moul.io/zapconfig"
)

func main() {
	if err := mainRun(os.Args[1:]); err != nil {
		if !errors.Is(err, flag.ErrHelp) {
			fmt.Fprintf(os.Stderr, "error: %v+\n", err)
		}
		os.Exit(1)
	}
}

var opts struct { // nolint:maligned
	Debug             bool
	BertyGroupInvite  string
	DiscordWebhookURL string
	BertyNodeAddr     string
	DiscordAnnounces  bool
	BertyAnnounces    bool
	rootLogger        *zap.Logger
}

func mainRun(args []string) error {
	// parse CLI
	root := &climan.Command{
		Name:       "berty-discord-webhook",
		ShortUsage: "berty-discord-webhook [global flags] <subcommand> [flags] [args]",
		ShortHelp:  "More info on https://moul.io/berty-discord-webhook.",
		FlagSetBuilder: func(fs *flag.FlagSet) {
			// opts.BertyNodeAddr = ""
			fs.BoolVar(&opts.Debug, "debug", opts.Debug, "debug mode")
			fs.StringVar(&opts.BertyGroupInvite, "berty-group-invite", opts.BertyGroupInvite, "Berty group invite")
			fs.StringVar(&opts.DiscordWebhookURL, "discord-webhook-url", opts.DiscordWebhookURL, "Discord Webhook URL")
			fs.BoolVar(&opts.DiscordAnnounces, "discord-announces", opts.DiscordAnnounces, "Announce debugging events on Discord")
			fs.BoolVar(&opts.BertyAnnounces, "berty-announces", opts.BertyAnnounces, "Announce debugging events on Berty")
			fs.StringVar(&opts.BertyNodeAddr, "berty-node-addr", opts.BertyNodeAddr, "Berty node address")
		},
		Exec:      doRoot,
		FFOptions: []ff.Option{ff.WithEnvVarPrefix("berty-discord-webhook")},
	}
	if err := root.Parse(args); err != nil {
		return fmt.Errorf("parse error: %w", err)
	}

	// init runtime
	{
		// prng
		rand.Seed(srand.Fast())

		// concurrency
		runtime.GOMAXPROCS(1)

		// logger
		config := zapconfig.New().SetPreset("light-console")
		if opts.Debug {
			config = config.SetLevel(zapcore.DebugLevel)
		} else {
			config = config.SetLevel(zapcore.InfoLevel)
		}
		var err error
		opts.rootLogger, err = config.Build()
		if err != nil {
			return fmt.Errorf("logger init: %w", err)
		}
	}

	// run
	if err := root.Run(context.Background()); err != nil {
		return fmt.Errorf("%w", err)
	}

	return nil
}

type discordMessage discordwebhook.Message

func (msg discordMessage) Log(logger *zap.Logger) {
	logger.Info(">>> " + *msg.Content)
}

func (msg discordMessage) Cast() discordwebhook.Message {
	return *(*discordwebhook.Message)(&msg)
}

type bertyMessage struct {
	msg string
}

func doRoot(ctx context.Context, args []string) error { // nolint:gocognit
	logger := opts.rootLogger.Named("app")
	logger.Debug("init", zap.Strings("args", args), zap.Any("opts", opts))

	if len(args) > 0 {
		return flag.ErrHelp
	}

	if opts.BertyNodeAddr == "" {
		// FIXME: implement inmem bot.
		return fmt.Errorf("missing --berty-node-addr: %w", flag.ErrHelp)
	}
	if opts.BertyGroupInvite == "" {
		return fmt.Errorf("missing --berty-group-invite: %w", flag.ErrHelp)
	}

	var (
		// FIXME: optimize chans
		discordQueue = make(chan *discordMessage, 10) // nolint:gomnd
		bertyQueue   = make(chan *bertyMessage, 10)   // nolint:gomnd
	)

	fmt.Print(motd.Default())

	if opts.BertyAnnounces {
		go func() { bertyQueue <- &bertyMessage{msg: "hello"} }()
	}

	var g run.Group
	ctx, cancel := context.WithCancel(ctx)
	g.Add(func() error {
		<-ctx.Done()
		return nil
	}, func(err error) {
		logger.Info("Exiting...", zap.Error(err))
		cancel()
	})
	g.Add(run.SignalHandler(ctx, syscall.SIGTERM, syscall.SIGINT, os.Interrupt, os.Kill))

	// discord dry-run
	if opts.DiscordWebhookURL == "" {
		content := "missing --discord-webhook-url, running in dry-run."
		go func() { discordQueue <- &discordMessage{Content: &content} }()
		g.Add(func() error {
			for {
				select {
				case msg := <-discordQueue:
					msg.Log(logger.Named("discord-dryrun"))
				case <-ctx.Done():
					return nil
				}
			}
		}, func(error) {})
	}

	// real discord
	if opts.DiscordWebhookURL != "" { // nolint:nestif
		if opts.DiscordAnnounces {
			go func() {
				content := "Hello World!"
				discordQueue <- &discordMessage{Content: &content}
			}()
		}

		g.Add(func() error {
			for {
				select {
				case msg := <-discordQueue:
					msg.Log(logger.Named("discord"))
					if err := discordwebhook.SendMessage(opts.DiscordWebhookURL, msg.Cast()); err != nil {
						if err.Error() != "" { // temporary fix
							logger.Warn("failed to send message on discord.", zap.Error(err))
						}
					}
				case <-ctx.Done():
					break
				}
			}
		}, func(error) {
			if opts.DiscordAnnounces {
				content := "Bye bye."
				msg := discordMessage{Content: &content}
				msg.Log(logger.Named("discord"))
				_ = discordwebhook.SendMessage(opts.DiscordWebhookURL, msg.Cast())
			}
		})
	}

	// berty
	g.Add(func() error {
		versionCommand := func(ctx bertybot.Context) {
			_ = ctx.ReplyString("version: " + bertyversion.Version)
		}
		userMessageHandler := func(ctx bertybot.Context) {
			// skip old events
			if ctx.IsReplay {
				return
			}
			// do not reply to myself
			if ctx.IsMine {
				return
			}
			// to avoid replying twice, only reply on the unacked message
			if ctx.Interaction.Acknowledged {
				return
			}

			content := ctx.UserMessage
			go func() { discordQueue <- &discordMessage{Content: &content} }()
		}

		cc, err := grpc.Dial(opts.BertyNodeAddr, grpc.WithInsecure())
		if err != nil {
			return fmt.Errorf("dial error: %w", err)
		}
		client := messengertypes.NewMessengerServiceClient(cc)

		newOpts := []bertybot.NewOption{}
		newOpts = append(newOpts,
			bertybot.WithLogger(logger.Named("berty")),                            // configure a logger
			bertybot.WithDisplayName("discord-webhook"),                           // bot name
			bertybot.WithHandler(bertybot.UserMessageHandler, userMessageHandler), // message handler
			bertybot.WithCommand("version", "show version", versionCommand),
			bertybot.WithMessengerClient(client),
			// bertybot.WithHandler(bertybot.PostAnythingHandler, botInitHandler),    // actions to run when bot is ready
			// bertybot.WithInsecureMessengerGRPCAddr(opts.BertyNodeAddr),            // connect to running berty messenger daemon
			// bertybot.WithRecipe(bertybot.AutoAcceptIncomingContactRequestRecipe()), // accept incoming contact requests
		)
		if opts.Debug {
			newOpts = append(newOpts, bertybot.WithRecipe(bertybot.DebugEventRecipe(logger.Named("debug"))))
		}
		if opts.BertyAnnounces {
			newOpts = append(newOpts, bertybot.WithRecipe(bertybot.WelcomeMessageRecipe("Hello world!")))
		}

		bot, err := bertybot.New(newOpts...)
		if err != nil {
			return fmt.Errorf("bot initialization failed: %w", err)
		}
		logger.Info("retrieve instance Berty ID",
			zap.String("pk", bot.PublicKey()),
			zap.String("link", bot.BertyIDURL()),
		)
		if opts.Debug {
			qrterminal.GenerateHalfBlock(bot.BertyIDURL(), qrterminal.L, os.Stdout)
		}

		fmt.Println(opts.BertyGroupInvite)
		req := &messengertypes.ConversationJoin_Request{Link: opts.BertyGroupInvite}
		_, err = client.ConversationJoin(ctx, req)
		if err != nil {
			logger.Warn("conversation join failed", zap.Error(err))
		} else {
			logger.Info("group joined")
		}

		return bot.Start(ctx)
	}, func(error) {})

	logger.Info("Starting...")
	return g.Run()
}
