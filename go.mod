module moul.io/berty-discord-webhook

go 1.25.0

require (
	berty.tech/berty/v2 v2.426.0
	github.com/gtuk/discordwebhook v1.0.1-0.20220609025812-cb8946075ce5
	github.com/mdp/qrterminal/v3 v3.0.0
	github.com/oklog/run v1.1.0
	github.com/peterbourgon/ff/v3 v3.1.2
	github.com/tailscale/depaware v0.0.0-20210622194025-720c4b409502
	go.uber.org/goleak v1.3.0
	go.uber.org/zap v1.21.0
	google.golang.org/grpc v1.83.1
	moul.io/climan v1.0.0
	moul.io/motd v1.0.0
	moul.io/srand v1.6.1
	moul.io/zapconfig v1.4.0
)

require (
	github.com/btcsuite/btcd v0.22.0-beta // indirect
	github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc // indirect
	github.com/dustin/go-humanize v1.0.1 // indirect
	github.com/go-kit/log v0.2.1 // indirect
	github.com/godbus/dbus/v5 v5.0.6 // indirect
	github.com/gofrs/uuid v3.4.0+incompatible // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/groupcache v0.0.0-20241129210726-2c02b8208cf8 // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/grpc-ecosystem/go-grpc-middleware v1.3.0 // indirect
	github.com/grpc-ecosystem/grpc-gateway v1.16.0 // indirect
	github.com/ipfs/go-log/v2 v2.4.0 // indirect
	github.com/klauspost/compress v1.18.0 // indirect
	github.com/klauspost/cpuid/v2 v2.2.5 // indirect
	github.com/kr/pretty v0.3.1 // indirect
	github.com/libp2p/go-libp2p-core v0.13.0 // indirect
	github.com/libp2p/go-openssl v0.0.7 // indirect
	github.com/maruel/circular v0.0.0-20200815005550-36e533b830e9 // indirect
	github.com/mattn/go-colorable v0.1.13 // indirect
	github.com/mattn/go-isatty v0.0.19 // indirect
	github.com/minio/sha256-simd v1.0.0 // indirect
	github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e // indirect
	github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2 // indirect
	github.com/prometheus/client_golang v1.21.1 // indirect
	github.com/prometheus/client_model v0.6.2 // indirect
	github.com/prometheus/common v0.63.0 // indirect
	github.com/prometheus/procfs v0.16.0 // indirect
	github.com/rogpeppe/go-internal v1.14.1 // indirect
	github.com/spacemonkeygo/spacelog v0.0.0-20180420211403-2296661a0572 // indirect
	github.com/stretchr/testify v1.11.1 // indirect
	go.opencensus.io v0.24.0 // indirect
	go.uber.org/atomic v1.9.0 // indirect
	go.uber.org/multierr v1.7.0 // indirect
	golang.org/x/crypto v0.51.0 // indirect
	golang.org/x/mod v0.35.0 // indirect
	golang.org/x/net v0.55.0 // indirect
	golang.org/x/sync v0.20.0 // indirect
	golang.org/x/sys v0.45.0 // indirect
	golang.org/x/text v0.37.0 // indirect
	golang.org/x/tools v0.44.0 // indirect
	golang.org/x/xerrors v0.0.0-20240903120638-7835f813f4da // indirect
	google.golang.org/genproto v0.0.0-20260128011058-8636f8732409 // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20260526163538-3dc84a4a5aaa // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260526163538-3dc84a4a5aaa // indirect
	google.golang.org/protobuf v1.36.11 // indirect
	moul.io/banner v1.0.1 // indirect
	moul.io/u v1.27.0 // indirect
	moul.io/zapfilter v1.7.0 // indirect
	moul.io/zapring v1.3.3 // indirect
	rsc.io/qr v0.2.0 // indirect
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
