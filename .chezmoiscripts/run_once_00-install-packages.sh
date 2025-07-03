#!/bin/bash

set -euo pipefail

# Error handler
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

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
        fcitx5-mozc
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "Detected macOS system"
    
    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Install packages only if not already installed
    for package in curl wget git zsh tmux neovim ripgrep fzf fontconfig age gh jq; do
        if ! brew list --formula | grep -q "^${package}$"; then
            echo "Installing ${package}..."
            brew install ${package}
        else
            echo "${package} is already installed"
        fi
    done
    
    # Install kitty on macOS if not already installed
    if ! command -v kitty &> /dev/null; then
        echo "Installing kitty..."
        brew install --cask kitty
    else
        echo "kitty is already installed"
    fi
    
    # Install yabai window manager
    if ! brew list --formula | grep -q "^yabai$"; then
        echo "Installing yabai window manager..."
        brew install koekeishiya/formulae/yabai
    else
        echo "yabai is already installed"
    fi
    
    # Install skhd hotkey daemon
    if ! brew list --formula | grep -q "^skhd$"; then
        echo "Installing skhd hotkey daemon..."
        brew install koekeishiya/formulae/skhd
    else
        echo "skhd is already installed"
    fi
    
    # Install sketchybar for status bar
    echo "Installing sketchybar..."
    brew tap FelixKratz/formulae
    
    # Handle potential SwiftBridging module errors by building from source
    if ! brew list sketchybar &>/dev/null; then
        echo "Installing SketchyBar from source to avoid SwiftBridging errors..."
        brew install --build-from-source FelixKratz/formulae/sketchybar
    else
        echo "SketchyBar already installed, checking for updates..."
        brew upgrade FelixKratz/formulae/sketchybar || true
    fi
    
    # Install Raycast for application launcher (free alternative to Alfred)
    if ! brew list --cask | grep -q "^raycast$"; then
        echo "Installing Raycast..."
        brew install --cask raycast
    else
        echo "Raycast is already installed"
    fi
    
    # Start yabai and skhd services
    echo "Configuring macOS window management services..."
    
    # Start or restart yabai service
    if ! pgrep -x "yabai" > /dev/null; then
        echo "Starting yabai service..."
        yabai --start-service 2>/dev/null || true
        brew services start yabai 2>/dev/null || true
    else
        echo "Restarting yabai service to load new configuration..."
        brew services restart yabai 2>/dev/null || true
    fi
    
    # Start or restart skhd service  
    if ! pgrep -x "skhd" > /dev/null; then
        echo "Starting skhd service..."
        skhd --start-service 2>/dev/null || true
        brew services start skhd 2>/dev/null || true
    else
        echo "Restarting skhd service to load new configuration..."
        brew services restart skhd 2>/dev/null || true
    fi
    
    # Start or restart sketchybar service
    if ! pgrep -x "sketchybar" > /dev/null; then
        echo "Starting sketchybar service..."
        brew services start sketchybar 2>/dev/null || true
    else
        echo "Restarting sketchybar service to load new configuration..."
        brew services restart sketchybar 2>/dev/null || true
    fi
    
    # Verify services are running
    echo ""
    echo "Service status:"
    brew services list | grep -E "yabai|skhd|sketchybar" || true
    
    # Note about SIP for advanced features
    echo ""
    echo "Note: For advanced yabai features (window opacity, borders), you may need to partially disable SIP."
    echo "See: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection"
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