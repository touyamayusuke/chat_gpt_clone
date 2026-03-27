# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/devcontainers/ruby:3.3-bookworm

ARG BUILDX_VERSION=v0.16.2
ARG TARGETARCH

RUN apt-get update -y && apt-get install -y --no-install-recommends \
  sqlite3 libsqlite3-dev socat docker.io curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/libexec/docker/cli-plugins \
  && curl -fsSL "https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.linux-${TARGETARCH}" -o /usr/libexec/docker/cli-plugins/docker-buildx \
  && chmod +x /usr/libexec/docker/cli-plugins/docker-buildx