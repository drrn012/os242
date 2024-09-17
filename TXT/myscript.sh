#!/bin/bash

# Define variables
TARBALL="myW02.tar.xz"
RESULT_DIR="$HOME/RESULT/W02"
SHA256SUM="SHA256SUM"
SIGNATURE="${TARBALL}.asc"
GPG_RECIPIENT="B7195518ADA8D9B9A8C4B7E2BD9A835916E7C831" # Replace with your GPG public key ID

# Debugging: Check the directory path and contents
echo "Checking the contents of RESULT_DIR..."
ls -l "$RESULT_DIR"

# Create the tarball
echo "Creating the tarball..."
if tar -cvJf "$TARBALL" -C "$HOME/RESULT" "W02"; then
    echo "Tarball created successfully: $TARBALL"
else
    echo "Failed to create tarball. Please check the RESULT_DIR path and permissions."
    exit 1
fi

# Encrypt the tarball
echo "Attempting to encrypt the tarball..."
if gpg --armor --output "$SIGNATURE" --encrypt --recipient "$GPG_RECIPIENT" "$TARBALL"; then
    echo "Encryption completed successfully."
else
    echo "Encryption failed. Please check GPG configuration and permissions."
    exit 1
fi

# Create checksum file
echo "Creating checksum file..."
sha256sum *.asc *.txt *.sh > "$SHA256SUM"

# Sign the checksum file
echo "Attempting to sign the checksum file..."
if gpg --armor --output "$SHA256SUM.asc" --detach-sign "$SHA256SUM"; then
    echo "Checksum file signed successfully."
else
    echo "Signing checksum file failed. Please check GPG configuration and permissions."
    exit 1
fi

# Verify the signature
echo "Verifying the checksum signature..."
if gpg --verify "$SHA256SUM.asc" "$SHA256SUM"; then
    echo "Signature verification successful."
else
    echo "Signature verification failed."
    exit 1
fi

# Print completion message
echo "Tarball created, encrypted, and signed: $TARBALL and $SIGNATURE"
echo "Checksum file created and signed: $SHA256SUM and $SHA256SUM.asc"
