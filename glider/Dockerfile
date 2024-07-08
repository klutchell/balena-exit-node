# https://github.com/nadoo/glider/blob/master/Dockerfile

FROM golang:1.22-alpine@sha256:8c9183f715b0b4eca05b8b3dbf59766aaedb41ec07477b132ee2891ac0110a07 AS build

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3018
RUN apk --no-cache add curl git

WORKDIR /src

# renovate: datasource=github-releases depName=nadoo/glider
ARG GLIDER_VERSION=v0.16.3

RUN curl -fsSL https://github.com/nadoo/glider/archive/refs/tags/v0.16.3.tar.gz | \
    tar -xz --strip-components=1

RUN go build -v -ldflags "-s -w"

FROM alpine:3.20@sha256:b89d9c93e9ed3597455c90a0b88a8bbb5cb7188438f70953fede212a0c4394e0

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
