#!/bin/bash
# Generate shortcut configurations when shortcuts.lua changes
# This runs automatically when the shortcuts definition file is modified

set -e

echo "🔧 Generating shortcut configurations..."

# Check if lua is installed
if ! command -v lua &> /dev/null; then
    echo "⚠️  Lua not found. Installing lua..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm lua
    else
        echo "❌ Could not install lua automatically. Please install it manually."
        exit 1
    fi
fi

# Wait for shortcuts-generate to exist (during initial chezmoi setup)
if [ ! -f ~/.local/bin/shortcuts-generate ]; then
    echo "⏳ Waiting for shortcuts-generate to be created..."
    sleep 1
fi

# Run the shortcuts generator
if [ -f ~/.local/bin/shortcuts-generate ]; then
    ~/.local/bin/shortcuts-generate
    
    # Only show reload message if generation was successful
    if [ $? -eq 0 ] && [ -f ~/.config/shortcuts/generated/tmux-keybindings.conf ]; then
        echo "✅ Shortcuts generated successfully!"
        echo ""
        echo "📝 Note: You may need to reload your configurations:"
        echo "   - tmux: Press Prefix+r (Ctrl+a r)"
        echo "   - i3: Press Mod+Shift+r (Alt+Shift+r)"
        echo "   - Shell: Open a new terminal or run 'source ~/.zshrc'"
    fi
else
    echo "⚠️  shortcuts-generate not found. This is normal during initial setup."
fi