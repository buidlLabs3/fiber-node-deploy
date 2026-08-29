#!/bin/sh
set -e

FIBER_HOME="${FIBER_HOME:-/fiber}"
KEY_FILE="$FIBER_HOME/ckb/key"
CONFIG_FILE="${FIBER_CONFIG:-$FIBER_HOME/config.yml}"

echo "=== FIBER WRAPPER: FIBER_HOME=$FIBER_HOME ==="

# Generate CKB key if it doesn't exist
if [ ! -f "$KEY_FILE" ]; then
  echo "Generating CKB key..."
  mkdir -p "$FIBER_HOME/ckb"
  dd if=/dev/urandom bs=32 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n' > "$KEY_FILE"
  chmod 600 "$KEY_FILE"
  echo "Key generated at $KEY_FILE"
fi

# Copy config if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Copying testnet config template..."
  TEMPLATE="/usr/local/share/fiber/config/testnet/config.yml"
  if [ -f "$TEMPLATE" ]; then
    cp "$TEMPLATE" "$CONFIG_FILE"
    echo "Config copied to $CONFIG_FILE"
  fi
fi

echo "=== Starting fnn ==="
exec fnn -c "$CONFIG_FILE" -d "$FIBER_HOME"
