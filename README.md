# Max's Dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Features

- **Terminal**: Kitty with Tokyo Night theme
- **Shell**: Zsh with Oh My Zsh
- **Window Manager**: i3 with gaps
- **Editor**: Neovim with modern plugins
- **Multiplexer**: Tmux with custom configuration
- **Font**: JetBrainsMono Nerd Font
- **Theme**: Tokyo Night color scheme

## Installation

### Prerequisites

Install chezmoi first:

```bash
# Arch Linux
sudo pacman -S chezmoi

# macOS
brew install chezmoi
```

### Deploy dotfiles

```bash
chezmoi init --apply programmatio
```

## What's included

- **Kitty** - GPU-based terminal emulator
- **Zsh** - Shell with Oh My Zsh framework
- **Neovim** - Text editor with LSP support
- **Tmux** - Terminal multiplexer with sessionizer
- **i3** - Tiling window manager (Arch Linux only)
- **Git** - Version control configuration
- **Bluetooth & Audio** - Auto-configured for Arch Linux
- **GitHub CLI** - Automatic SSH key registration for new machines
- **Age encryption** - Secure storage for sensitive files

## Key Bindings

### i3 (Mod = Super/Windows key)
- `Mod+Return` - Open terminal (Kitty)
- `Mod+d` - Application launcher (Rofi)
- `Mod+h/j/k/l` - Navigate windows
- `Mod+Shift+h/j/k/l` - Move windows
- `Mod+1-0` - Switch workspaces
- `Mod+Shift+q` - Close window
- `Mod+x` - Lock screen

### Tmux (Prefix = Ctrl+a)
- `Ctrl+a |` - Split vertically
- `Ctrl+a -` - Split horizontally
- `Ctrl+a h/j/k/l` - Navigate panes
- `Ctrl+f` - Tmux sessionizer

### Neovim (Leader = Space)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>e` - File explorer
- `gd` - Go to definition
- `K` - Hover documentation

## Supported Systems

- Arch Linux
- macOS

## New Machine Setup

When setting up a new machine:

1. Install chezmoi and clone dotfiles:
   ```bash
   chezmoi init --apply programmatio
   ```

2. The setup will automatically:
   - Install all required packages
   - Generate SSH keys
   - Set up age encryption for sensitive files

3. After installation completes, run:
   ```bash
   github-setup
   ```
   This will:
   - Authenticate you with GitHub (via browser or token)
   - Automatically register your SSH key
   - Test the connection

4. For accessing encrypted files on additional machines, see [ENCRYPTION.md](ENCRYPTION.md)