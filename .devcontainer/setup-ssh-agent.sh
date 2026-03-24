#!/usr/bin/env bash
set -euo pipefail

SOURCE_SOCKET="/ssh-agent"
TARGET_SOCKET="/tmp/ssh-agent-vscode.sock"

if [[ ! -S "$SOURCE_SOCKET" ]]; then
  exit 0
fi

sudo pkill -f "socat .*${TARGET_SOCKET}" >/dev/null 2>&1 || true
sudo rm -f "$TARGET_SOCKET"

sudo socat \
  UNIX-LISTEN:"$TARGET_SOCKET",fork,user=vscode,group=vscode,mode=600 \
  UNIX-CONNECT:"$SOURCE_SOCKET" \
  >/tmp/ssh-agent-proxy.log 2>&1 &
