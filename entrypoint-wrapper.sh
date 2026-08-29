#!/bin/sh
set -x
set -e

FIBER_HOME="${FIBER_HOME:-/fiber}"
KEY_FILE="$FIBER_HOME/ckb/key"
CONFIG_FILE="$FIBER_HOME/config.yml"

echo "=== FIBER WRAPPER STARTING ==="
echo "FIBER_HOME=$FIBER_HOME"

# Generate CKB key if it doesn't exist
if [ ! -f "$KEY_FILE" ]; then
  echo "No CKB key found, generating one..."
  mkdir -p "$FIBER_HOME/ckb"
  dd if=/dev/urandom bs=32 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n' > "$KEY_FILE"
  chmod 600 "$KEY_FILE"
  echo "Key generated successfully"
else
  echo "Key already exists at $KEY_FILE"
fi

# Copy default testnet config if config.yml doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
  echo "No config.yml found, looking for template..."
  TEMPLATE="/usr/local/share/fiber/config/testnet/config.yml"
  if [ -f "$TEMPLATE" ]; then
    mkdir -p "$(dirname "$CONFIG_FILE")"
    cp "$TEMPLATE" "$CONFIG_FILE"
    echo "Config copied from $TEMPLATE"
  else
    echo "WARNING: No config template found at $TEMPLATE"
    echo "Listing available configs:"
    find /usr/local/share/fiber -name "*.yml" 2>/dev/null || true
  fi
else
  echo "Config already exists at $CONFIG_FILE"
fi

echo "=== STARTING FIBER NODE ==="
# Start the node - pass all args through
exec "$@"
