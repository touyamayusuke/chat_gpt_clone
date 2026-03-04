# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/devcontainers/ruby:3.3-bookworm

RUN apt-get update -y && apt-get install -y --no-install-recommends \
  sqlite3 libsqlite3-dev \
  && rm -rf /var/lib/apt/lists/*