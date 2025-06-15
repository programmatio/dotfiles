#!/bin/bash

set -e

echo "Installing required packages..."

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Arch Linux
    echo "Detected Arch Linux system"
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
        fcitx5-mozc
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "Detected macOS system"
    
    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    brew install \
        curl \
        wget \
        git \
        zsh \
        tmux \
        neovim \
        ripgrep \
        fzf \
        fontconfig \
        age \
        gh
    
    # Install kitty on macOS
    brew install --cask kitty
fi

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

# Enable Bluetooth service on Arch Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Enabling Bluetooth service..."
    sudo systemctl enable bluetooth.service
    sudo systemctl start bluetooth.service
fi

# Setup Japanese locale support
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Setting up Japanese locale support..."
    sudo sed -i 's/#ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
    sudo locale-gen
fi

echo "All packages installed successfully!"