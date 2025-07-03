#!/usr/bin/env bash

# Post-install message with setup instructions

echo ""
echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║                    Dotfiles Installation Complete!                  ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""

# Platform-specific instructions
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 macOS Setup Instructions:"
    echo ""
    echo "1. ACCESSIBILITY PERMISSIONS (Required for window management):"
    echo "   - Open System Settings → Privacy & Security → Accessibility"
    echo "   - Add and enable: yabai, skhd, and kitty"
    echo "   - Without this, window focus commands won't work!"
    echo ""
    echo "2. Start window management services:"
    echo "   brew services start yabai"
    echo "   brew services start skhd"
    echo "   brew services start sketchybar"
    echo ""
    echo "3. Optional: For advanced features (borders, opacity):"
    echo "   - Partially disable SIP (requires reboot to Recovery Mode)"
    echo "   - Run: csrutil enable --without fs --without debug --without nvram"
    echo ""
elif [[ -f /etc/arch-release ]]; then
    echo "🐧 Arch Linux Setup Instructions:"
    echo ""
    echo "1. Start window manager:"
    echo "   - Log out and select i3 from your display manager"
    echo ""
fi

echo "📝 Common Next Steps:"
echo ""
echo "1. Set up SSH keys:"
echo "   - Your SSH key was generated at ~/.ssh/id_ed25519"
echo "   - Add to GitHub: https://github.com/settings/keys"
echo "   - Public key:"
echo ""
if [[ -f ~/.ssh/id_ed25519.pub ]]; then
    cat ~/.ssh/id_ed25519.pub
else
    echo "   (SSH key not found - run: ssh-keygen -t ed25519)"
fi
echo ""
echo "2. Configure git:"
echo "   git config --global user.name \"Your Name\""
echo "   git config --global user.email \"your.email@example.com\""
echo ""
echo "3. Reload your shell:"
echo "   source ~/.zshrc"
echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "Happy coding! 🚀"
echo ""