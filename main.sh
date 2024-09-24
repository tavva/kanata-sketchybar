#! /usr/bin/env zsh

set -euo pipefail

zmodload zsh/net/tcp

port=${KANATA_PORT-12345}
ztcp 127.0.0.1 $port
fdRead=$REPLY

/opt/homebrew/bin/rg 'LayerChange' --line-buffered <&$fdRead | while read -r message; do
  layer=$(echo "$message" | /opt/homebrew/bin/jq -r '.LayerChange.new')
  printf "LayerChange: %s\n" "$layer"
  /opt/homebrew/bin/sketchybar --set keyboard-layer label="$layer"
done
