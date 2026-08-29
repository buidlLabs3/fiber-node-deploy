#!/bin/sh

FIBER_HOME="${FIBER_HOME:-/fiber}"
KEY_FILE="$FIBER_HOME/ckb/key"
CONFIG_FILE="${FIBER_CONFIG:-$FIBER_HOME/config.yml}"
TEMPLATE="/usr/local/share/fiber/config/testnet/config.yml"

mkdir -p "$FIBER_HOME/ckb"

# Generate CKB key if it doesn't exist
if [ ! -f "$KEY_FILE" ]; then
  echo "Generating CKB key..." >&2
  dd if=/dev/urandom bs=32 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n' > "$KEY_FILE"
  chmod 600 "$KEY_FILE"
  echo "Key generated" >&2
fi

# ALWAYS copy config (in case volume overlay hid the build-time copy)
if [ ! -f "$CONFIG_FILE" ] && [ -f "$TEMPLATE" ]; then
  echo "Copying testnet config..." >&2
  cp "$TEMPLATE" "$CONFIG_FILE"
fi

# Fallback: if still no config, try inline
if [ ! -f "$CONFIG_FILE" ]; then
  echo "WARNING: No config file at $CONFIG_FILE or $TEMPLATE" >&2
fi

exec fnn -c "$CONFIG_FILE" -d "$FIBER_HOME"
