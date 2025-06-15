#!/bin/bash

set -e

echo "Installing JetBrainsMono Nerd Font..."

# Create fonts directory
mkdir -p ~/.local/share/fonts

# Download and install JetBrainsMono Nerd Font
cd /tmp
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip -q JetBrainsMono.zip -d JetBrainsMono
cp JetBrainsMono/*.ttf ~/.local/share/fonts/
rm -rf JetBrainsMono.zip JetBrainsMono

# Update font cache
fc-cache -fv ~/.local/share/fonts/

echo "JetBrainsMono Nerd Font installed successfully!"