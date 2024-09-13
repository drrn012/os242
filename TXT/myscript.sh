#!/bin/bash

# Define variables
TARBALL="myW02.tar.xz"
RESULT_DIR="RESULT/W02"
SIGNATURE="${TARBALL}.asc"

# Create the tarball
tar -cvJf "$TARBALL" "$RESULT_DIR"

# Encrypt and sign the tarball (requires gpg setup)
echo "Attempting to sign the tarball..."
if gpg --detach-sign "$TARBALL"; then
    echo "Signing completed successfully."
else
    echo "Signing failed. Please check GPG configuration and permissions."
    exit 1
fi

# Print completion message
echo "Tarball created and signed: $TARBALL and $SIGNATURE"
