#!/bin/bash

set -e

echo "Installing JetBrainsMono Nerd Font..."

# Create fonts directory
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Check if font is already installed
if ls "$FONT_DIR"/JetBrainsMono*NerdFont*.ttf 1> /dev/null 2>&1; then
    echo "JetBrainsMono Nerd Font is already installed"
    exit 0
fi

# Get latest version from GitHub API
echo "Fetching latest Nerd Font version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep -o '"tag_name": "v[^"]*"' | cut -d'"' -f4)

if [ -z "$LATEST_VERSION" ]; then
    echo "Warning: Could not fetch latest version, using v3.2.1"
    LATEST_VERSION="v3.2.1"
fi

echo "Downloading JetBrainsMono Nerd Font ${LATEST_VERSION}..."

# Download and install JetBrainsMono Nerd Font
cd /tmp
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${LATEST_VERSION}/JetBrainsMono.zip"

if ! wget -q "$FONT_URL" -O JetBrainsMono.zip; then
    echo "Error: Failed to download font. Trying fallback version..."
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
    wget -q "$FONT_URL" -O JetBrainsMono.zip
fi

unzip -q JetBrainsMono.zip -d JetBrainsMono
cp JetBrainsMono/*.ttf "$FONT_DIR/"
rm -rf JetBrainsMono.zip JetBrainsMono

# Update font cache
if command -v fc-cache &> /dev/null; then
    fc-cache -fv "$FONT_DIR/"
fi

echo "JetBrainsMono Nerd Font ${LATEST_VERSION} installed successfully!"