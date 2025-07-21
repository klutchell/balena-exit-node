# https://github.com/nadoo/glider/blob/master/Dockerfile

FROM golang:1.24-alpine@sha256:daae04ebad0c21149979cd8e9db38f565ecefd8547cf4a591240dc1972cf1399 AS build

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3018
RUN apk --no-cache add curl git

WORKDIR /src

# renovate: datasource=github-releases depName=nadoo/glider
ARG GLIDER_VERSION=v0.16.4

RUN curl -fsSL https://github.com/nadoo/glider/archive/refs/tags/v0.16.3.tar.gz | \
    tar -xz --strip-components=1

RUN go build -v -ldflags "-s -w"

FROM alpine:3.22@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

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
