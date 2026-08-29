#!/bin/sh
set -e

FIBER_HOME="${FIBER_HOME:-/fiber}"
KEY_FILE="$FIBER_HOME/ckb/key"

# Generate CKB key if it doesn't exist
if [ ! -f "$KEY_FILE" ]; then
  echo "No CKB key found, generating one..."
  mkdir -p "$FIBER_HOME/ckb"
  # Generate a random 32-byte hex key (64 hex chars, no 0x prefix)
  dd if=/dev/urandom bs=32 count=1 2>/dev/null | od -An -tx1 | tr -d ' \n' > "$KEY_FILE"
  chmod 600 "$KEY_FILE"
  echo "Key generated successfully"
fi

# Start the node
exec fnn -c "$FIBER_HOME/config.yml" -d "$FIBER_HOME"
