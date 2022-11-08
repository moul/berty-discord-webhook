module moul.io/berty-discord-webhook

go 1.13

require (
	berty.tech/berty/v2 v2.436.0
	github.com/gtuk/discordwebhook v1.0.1-0.20220609025812-cb8946075ce5
	github.com/mdp/qrterminal/v3 v3.0.0
	github.com/oklog/run v1.1.0
	github.com/peterbourgon/ff/v3 v3.1.2
	github.com/tailscale/depaware v0.0.0-20210622194025-720c4b409502
	go.uber.org/goleak v1.1.12
	go.uber.org/zap v1.23.0
	google.golang.org/grpc v1.42.0
	moul.io/climan v1.0.0
	moul.io/motd v1.0.0
	moul.io/srand v1.6.1
	moul.io/zapconfig v1.4.0
)

replace (
	bazil.org/fuse => bazil.org/fuse v0.0.0-20200117225306-7b5117fecadc // specific version for iOS building
	github.com/agl/ed25519 => github.com/agl/ed25519 v0.0.0-20170116200512-5312a6153412 // latest commit before the author shutdown the repo; see https://github.com/golang/go/issues/20504
	github.com/libp2p/go-libp2p-rendezvous => github.com/berty/go-libp2p-rendezvous v0.0.0-20211013085524-09965cd64781 // use berty fork of go-libp2p-rendezvous with sqlcipher support
	github.com/lucas-clemente/quic-go => github.com/lucas-clemente/quic-go v0.25.0

	github.com/multiformats/go-multiaddr => github.com/berty/go-multiaddr v0.4.2-0.20220126184027-53e56f02fb68 // tmp, required for Android SDK30
	github.com/mutecomm/go-sqlcipher/v4 => github.com/berty/go-sqlcipher/v4 v4.0.0-20211104165006-2c524b646cf0
	github.com/peterbourgon/ff/v3 => github.com/moul/ff/v3 v3.0.1 // temporary, see https://github.com/peterbourgon/ff/pull/67, https://github.com/peterbourgon/ff/issues/68
	golang.org/x/mobile => github.com/aeddi/mobile v0.0.4 // temporary, see https://github.com/golang/mobile/pull/58
)
