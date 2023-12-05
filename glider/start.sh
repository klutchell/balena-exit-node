#!/bin/sh

if [ $# -gt 0 ]; then
  exec /app/glider "$@"
fi

PROXY_SCHEME="${PROXY_SCHEME:-socks5}"
PROXY_HOST="${PROXY_HOST:-0.0.0.0}"
PROXY_PORT="${PROXY_PORT:-8443}"

listen="${PROXY_SCHEME}://${PROXY_HOST}:${PROXY_PORT}"

if [ -n "${PROXY_USER}" ] && [ -n "${PROXY_PASS}" ]; then
  listen="${PROXY_SCHEME}://${PROXY_USER}:${PROXY_PASS}@${PROXY_HOST}:${PROXY_PORT}"
fi

exec /app/glider -verbose -listen "${listen}"
