GOPKG ?=	moul.io/berty-discord-webhook
DOCKER_IMAGE ?=	moul/berty-discord-webhook
GOBINS ?=	.
NPM_PACKAGES ?=	.

include rules.mk

generate: install
	GO111MODULE=off go get github.com/campoy/embedmd
	mkdir -p .tmp
	echo 'foo@bar:~$$ berty-discord-webhook -h' > .tmp/usage.txt
	-berty-discord-webhook -h 2>> .tmp/usage.txt
	embedmd -w README.md
	rm -rf .tmp
.PHONY: generate
