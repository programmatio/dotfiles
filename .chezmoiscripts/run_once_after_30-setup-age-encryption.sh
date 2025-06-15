#!/bin/bash

set -e

AGE_DIR="$HOME/.config/age"
AGE_KEY="$AGE_DIR/key.txt"
CHEZMOI_CONFIG="$HOME/.config/chezmoi/chezmoi.toml"

# Create age directory
mkdir -p "$AGE_DIR"
chmod 700 "$AGE_DIR"

# Generate age key if it doesn't exist
if [ ! -f "$AGE_KEY" ]; then
    echo "Generating age encryption key..."
    age-keygen -o "$AGE_KEY" 2>&1
    chmod 600 "$AGE_KEY"
    
    echo ""
    echo "IMPORTANT: Your age key has been generated at $AGE_KEY"
    echo "This key is used to encrypt/decrypt your sensitive files."
    echo ""
    echo "Your age public key is:"
    grep "public key:" "$AGE_KEY" | cut -d' ' -f4
    echo ""
    echo "BACKUP THIS KEY SECURELY! You'll need it on all your systems."
    echo "Consider using a password manager or secure cloud storage."
    echo ""
    read -p "Press Enter when you've backed up your key..."
fi

# Create chezmoi config directory
mkdir -p "$(dirname "$CHEZMOI_CONFIG")"

# Create or update chezmoi config
if [ ! -f "$CHEZMOI_CONFIG" ]; then
    cat > "$CHEZMOI_CONFIG" << EOF
encryption = "age"
[age]
    identity = "$AGE_KEY"
    recipient = "$(grep "public key:" "$AGE_KEY" | cut -d' ' -f4)"
EOF
    echo "Chezmoi encryption configured!"
else
    echo "Chezmoi config already exists. Please manually add age encryption settings if needed."
fi