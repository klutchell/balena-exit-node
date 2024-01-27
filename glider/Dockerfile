# https://github.com/nadoo/glider/blob/master/Dockerfile

FROM golang:1.21-alpine@sha256:a49e5101be836613e432f0911b66a47dd48b50ebcd720717f70a30968237789e AS build

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3018
RUN apk --no-cache add curl git

WORKDIR /src

# renovate: datasource=github-releases depName=nadoo/glider
ARG GLIDER_VERSION=v0.16.3

RUN curl -fsSL https://github.com/nadoo/glider/archive/refs/tags/v0.16.3.tar.gz | \
    tar -xz --strip-components=1

RUN go build -v -ldflags "-s -w"

FROM alpine:3.19@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

COPY --from=build /src/glider /app/

WORKDIR /app

# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates

COPY start.sh ./
RUN chmod +x start.sh

USER 1000

ENTRYPOINT ["/app/start.sh"]

ENV PROXY_SCHEME socks5
ENV PROXY_HOST 0.0.0.0
ENV PROXY_PORT 8443
