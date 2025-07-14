#!/usr/bin/env bash

set -euo pipefail

# Post-install message with setup instructions

echo ""
echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║                    Dotfiles Installation Complete!                  ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""

# Arch Linux setup instructions
echo "🐧 Arch Linux Setup Instructions:"
echo ""
echo "1. Start window manager:"
echo "   - Log out and select i3 from your display manager"
echo ""

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