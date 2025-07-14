#!/bin/bash

set -euo pipefail

# Error handler
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

echo "Installing required packages..."

# Install packages for Arch Linux
echo "Installing Arch Linux packages..."
sudo pacman -Syu --noconfirm \
    curl \
    wget \
    git \
    zsh \
    tmux \
    neovim \
    ripgrep \
    fzf \
    base-devel \
    unzip \
    fontconfig \
    xclip \
    kitty \
    i3-wm \
    i3status \
    i3blocks \
    i3lock \
    dmenu \
    rofi \
    dunst \
    picom \
    feh \
    bluez \
    bluez-utils \
    blueman \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    pipewire-jack \
    wireplumber \
    pavucontrol \
    pasystray \
    noto-fonts-emoji \
    playerctl \
    brightnessctl \
    network-manager-applet \
    xss-lock \
    polkit-gnome \
    age \
    openssh \
    github-cli \
    noto-fonts-cjk \
    fcitx5-im \
    fcitx5-mozc \
    nodejs \
    npm \
    go \
    keyd

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

# Enable Bluetooth service
echo "Enabling Bluetooth service..."
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# Setup Japanese locale support
echo "Setting up Japanese locale support..."
sudo sed -i 's/#ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen

echo "All packages installed successfully!"