module moul.io/berty-discord-webhook

go 1.18

require (
	berty.tech/berty/v2 v2.425.0
	github.com/gtuk/discordwebhook v1.0.2
	github.com/mdp/qrterminal/v3 v3.0.0
	github.com/oklog/run v1.1.0
	github.com/peterbourgon/ff/v3 v3.1.2
	github.com/tailscale/depaware v0.0.0-20210622194025-720c4b409502
	go.uber.org/goleak v1.1.12
	go.uber.org/zap v1.21.0
	google.golang.org/grpc v1.48.0
	moul.io/climan v1.0.0
	moul.io/motd v1.0.0
	moul.io/srand v1.6.1
	moul.io/zapconfig v1.4.0
)

require (
	github.com/btcsuite/btcd v0.22.0-beta // indirect
	github.com/gofrs/uuid v3.4.0+incompatible // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/protobuf v1.5.2 // indirect
	github.com/grpc-ecosystem/go-grpc-middleware v1.3.0 // indirect
	github.com/grpc-ecosystem/grpc-gateway v1.16.0 // indirect
	github.com/ipfs/go-log/v2 v2.4.0 // indirect
	github.com/klauspost/cpuid/v2 v2.0.9 // indirect
	github.com/libp2p/go-libp2p-core v0.13.0 // indirect
	github.com/libp2p/go-openssl v0.0.7 // indirect
	github.com/maruel/circular v0.0.0-20200815005550-36e533b830e9 // indirect
	github.com/mattn/go-isatty v0.0.14 // indirect
	github.com/minio/sha256-simd v1.0.0 // indirect
	github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e // indirect
	github.com/spacemonkeygo/spacelog v0.0.0-20180420211403-2296661a0572 // indirect
	go.uber.org/atomic v1.9.0 // indirect
	go.uber.org/multierr v1.7.0 // indirect
	golang.org/x/crypto v0.0.0-20220411220226-7b82a4e95df4 // indirect
	golang.org/x/mod v0.5.0 // indirect
	golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2 // indirect
	golang.org/x/sys v0.0.0-20211216021012-1d35b9e2eb4e // indirect
	golang.org/x/text v0.3.7 // indirect
	golang.org/x/tools v0.1.8-0.20211022200916-316ba0b74098 // indirect
	golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1 // indirect
	google.golang.org/genproto v0.0.0-20211208223120-3a66f561d7aa // indirect
	google.golang.org/protobuf v1.27.1 // indirect
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
