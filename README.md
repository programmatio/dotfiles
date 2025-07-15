# Max's Dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start (Fresh Machine)

### Step 1: Install chezmoi and initialize
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply programmatio
```

### Step 2: If using local directory instead
```bash
# Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# Clone your dotfiles repo
git clone https://github.com/programmatio/dotfiles.git ~/personal/dotfiles

# Initialize chezmoi with local source
chezmoi init --source ~/personal/dotfiles --apply
```

### Step 3: Update dotfiles after making changes
```bash
# Add changed files
chezmoi add ~/.config/i3/config
chezmoi add ~/.zshrc

# Commit and push
cd ~/personal/dotfiles
git add .
git commit -m "Update configs"
git push
```

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
```

### Deploy dotfiles

```bash
chezmoi init --apply programmatio
```

## What's included

### Core Applications
- **Kitty** - GPU-based terminal emulator with Tokyo Night theme
- **Zsh** - Shell with Oh My Zsh framework and plugins
- **Neovim** - Text editor with LSP support and modern plugins
- **Tmux** - Terminal multiplexer with sessionizer
- **Git** - Version control with custom configuration

### Window Management (i3 Desktop Environment)
- **i3** - Tiling window manager with gaps and custom keybindings
- **Rofi** - Application launcher and window switcher
- **Picom** - Compositor for window transparency and effects
- **Dunst** - Notification daemon for desktop notifications
- **i3status/i3blocks** - Status bar with system information

### Audio & Media
- **PipeWire** - Modern audio server with ALSA/JACK/Pulse compatibility
- **Pavucontrol** - Audio control interface
- **Playerctl** - Media player control

### System Tools
- **Bluetooth & Audio** - Auto-configured for Arch Linux
- **Network Manager** - Network connection management
- **Brightnessctl** - Display brightness control
- **GitHub CLI** - Automatic SSH key registration for new machines
- **Age encryption** - Secure storage for sensitive files
- **Shortcuts System** - Centralized keybinding management with auto-generation
- **Shortcuts Help** - Vimium-style overlay showing all keyboard shortcuts

## Shortcuts System

All keybindings and aliases are managed centrally through `~/.config/shortcuts/shortcuts.lua`. This provides:

- **Single source of truth** - Define shortcuts once, use everywhere
- **Auto-generation** - Config files are generated automatically
- **Unified help** - All shortcuts accessible via help overlay
- **Easy customization** - Edit one Lua file to change all bindings

### Managing Shortcuts

1. Edit shortcuts definition:
   ```bash
   vim ~/.config/shortcuts/shortcuts.lua
   ```

2. Changes are applied automatically with chezmoi:
   ```bash
   chezmoi apply
   ```

3. Or manually regenerate:
   ```bash
   shortcuts-generate
   ```

### Viewing Shortcuts

- **Universal**: Press `Alt+Shift+?` (works in both tmux and i3)
- **Command line**: Run `shortcuts-help`

### Key Bindings Overview

The shortcuts system manages bindings for:
- **i3 window manager** - Window navigation, workspaces, layouts
- **tmux** - Panes, windows, sessions
- **Shell aliases** - Git, navigation, applications
- **Custom tools** - Tmux sessionizer, shortcuts help

For a complete list of shortcuts, use the help overlay (`Alt+Shift+?`).

## Repository Structure

```
.
├── .chezmoiscripts/           # Scripts that run during chezmoi apply
│   ├── run_onchange_*         # Run when script content changes
│   └── run_once_*             # Run only once
├── .chezmoitemplates/         # Reusable template snippets
├── dot_config/                # ~/.config directory
│   ├── dunst/                 # Notification daemon config
│   ├── fontconfig/            # Font configuration
│   ├── i3/                    # i3 window manager
│   ├── i3status/              # i3 status bar
│   ├── kitty/                 # Terminal emulator
│   ├── nvim/                  # Neovim configuration
│   ├── picom/                 # Compositor config
│   ├── rofi/                  # Application launcher
│   └── shortcuts/             # Centralized shortcuts configuration
│       └── shortcuts.lua      # All keybindings and aliases
├── dot_local/                 # ~/.local directory
│   └── bin/                   # User scripts
│       ├── shortcuts-generate # Generate configs from shortcuts.lua
│       ├── shortcuts-help     # Display shortcuts overlay
│       └── executable_*       # Other executable scripts
├── dot_gitconfig.tmpl         # Git configuration template
├── dot_tmux.conf              # Tmux configuration
├── dot_zshrc                  # Zsh shell configuration
├── .chezmoi.toml.tmpl         # Chezmoi config template
├── .chezmoiignore             # Files to ignore during apply
└── .chezmoiremove             # Files to remove during apply
```

### Chezmoi Naming Conventions

- **`dot_`** prefix: Creates dotfiles (e.g., `dot_zshrc` → `~/.zshrc`)
- **`executable_`** prefix: Sets execute permission on files
- **`.tmpl`** suffix: Template files processed by chezmoi
- **`run_onchange_`**: Scripts that run when their content changes
- **`run_once_`**: Scripts that run only once per machine
- **`private_`** prefix: Creates files with 600 permissions (not used currently)

## Supported System

- Arch Linux

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