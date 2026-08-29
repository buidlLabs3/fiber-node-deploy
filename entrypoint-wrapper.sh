#!/bin/sh

FIBER_HOME="/fiber"
KEY_FILE="$FIBER_HOME/ckb/key"
CONFIG_FILE="/fiber/config.yml"
TEMPLATE="/usr/local/share/fiber/config/testnet/config.yml"

echo "=== Fiber Wrapper Starting ==="

# Generate CKB key if missing
if [ ! -f "$KEY_FILE" ]; then
  echo "Generating CKB key..."
  mkdir -p "$FIBER_HOME/ckb"
  dd if=/dev/urandom bs=32 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n' > "$KEY_FILE"
  chmod 600 "$KEY_FILE"
  echo "Key generated"
fi

# Ensure config exists
if [ ! -f "$CONFIG_FILE" ] && [ -f "$TEMPLATE" ]; then
  echo "Copying testnet config..."
  cp "$TEMPLATE" "$CONFIG_FILE"
fi

echo "=== Starting fnn ==="
# Hardcoded command — no reliance on CMD or exec "$@"
exec fnn -c /fiber/config.yml -d /fiber
