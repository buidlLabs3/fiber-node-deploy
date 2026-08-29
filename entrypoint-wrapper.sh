#!/bin/sh
set -e

FIBER_HOME="${FIBER_HOME:-/fiber}"
KEY_FILE="$FIBER_HOME/ckb/key"
CONFIG_FILE="$FIBER_HOME/config.yml"

# Generate CKB key if it doesn't exist
if [ ! -f "$KEY_FILE" ]; then
  echo "No CKB key found, generating one..."
  mkdir -p "$FIBER_HOME/ckb"
  dd if=/dev/urandom bs=32 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n' > "$KEY_FILE"
  chmod 600 "$KEY_FILE"
  echo "Key generated successfully"
fi

# Copy default testnet config if config.yml doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
  echo "No config.yml found, copying testnet template..."
  TEMPLATE="/usr/local/share/fiber/config/testnet/config.yml"
  if [ -f "$TEMPLATE" ]; then
    cp "$TEMPLATE" "$CONFIG_FILE"
    echo "Config copied from $TEMPLATE"
  else
    echo "WARNING: No config template found at $TEMPLATE"
  fi
fi

# Start the node
exec fnn -c "$CONFIG_FILE" -d "$FIBER_HOME"
