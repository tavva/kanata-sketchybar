#! /usr/bin/env zsh

set -euo pipefail

zmodload zsh/net/tcp

port=${KANATA_PORT-12345}
ztcp 127.0.0.1 $port
fdRead=$REPLY

/opt/homebrew/bin/rg 'LayerChange' --line-buffered <&$fdRead | while read -r message; do
  layer=$(echo "$message" | /opt/homebrew/bin/jq -r '.LayerChange.new')
  printf "LayerChange: %s\n" "$layer"
  if [ "$layer" = "base" ]; then
    /opt/homebrew/bin/sketchybar --set keyboard-layer label="$layer" label.color="0xffffffff" background.color="0x00000000"
    /opt/homebrew/bin/sketchybar --bar color="0x00000000"
    /opt/homebrew/bin/focusbar --set keyboard-layer label="$layer" label.color="0xffffffff" background.color="0x00000000"
    /opt/homebrew/bin/focusbar --bar color="0x00000000"
  else
    /opt/homebrew/bin/sketchybar --set keyboard-layer label="$layer" label.color="0xffffff00" background.color="0xffde3163"
    /opt/homebrew/bin/sketchybar --bar color="0x44de3163"
    /opt/homebrew/bin/focusbar --set keyboard-layer label="$layer" label.color="0xffffff00" background.color="0xffde3163"
    /opt/homebrew/bin/focusbar --bar color="0x44de3163"
  fi
done
