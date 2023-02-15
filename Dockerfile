# dynamic config
ARG             BUILD_DATE
ARG             VCS_REF
ARG             VERSION

# build
FROM            golang:1.20.1-alpine as builder
RUN             apk add --no-cache git gcc musl-dev make
ENV             GO111MODULE=on
WORKDIR         /go/src/moul.io/berty-discord-webhook
COPY            go.* ./
RUN             go mod download
COPY            . ./
RUN             make install

# minimalist runtime
FROM alpine:3.16.1
LABEL           org.label-schema.build-date=$BUILD_DATE \
                org.label-schema.name="berty-discord-webhook" \
                org.label-schema.description="" \
                org.label-schema.url="https://moul.io/berty-discord-webhook/" \
                org.label-schema.vcs-ref=$VCS_REF \
                org.label-schema.vcs-url="https://github.com/moul/berty-discord-webhook" \
                org.label-schema.vendor="Manfred Touron" \
                org.label-schema.version=$VERSION \
                org.label-schema.schema-version="1.0" \
                org.label-schema.cmd="docker run -i -t --rm moul/berty-discord-webhook" \
                org.label-schema.help="docker exec -it $CONTAINER berty-discord-webhook --help"
COPY            --from=builder /go/bin/berty-discord-webhook /bin/
ENTRYPOINT      ["/bin/berty-discord-webhook"]
#CMD             []
