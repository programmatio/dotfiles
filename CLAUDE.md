# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by chezmoi, providing automated setup for development environments on Arch Linux. The repository uses age encryption for sensitive files and includes automated package installation and configuration.

## Essential Commands

### Dotfiles Management
```bash
# Add a config file to dotfiles
chezmoi add ~/.config/file

# Apply changes after editing source files
chezmoi apply

# Update from remote and apply
chezmoi update

# See what changes would be applied
chezmoi diff

# Edit and apply a specific file
chezmoi edit ~/.config/file --apply
```

### Testing Changes
```bash
# Test script changes before committing
bash .chezmoiscripts/run_once_00-install-packages.sh

# Verify age encryption setup
age -d ~/.config/chezmoi/key.txt.age
```

## Architecture & Key Components

### Repository Structure
```
.
├── .chezmoiscripts/           # Automated setup scripts
│   ├── run_onchange_00-install-packages.sh
│   ├── run_onchange_10-install-nerd-font.sh
│   ├── run_onchange_50-generate-shortcuts.sh  # Auto-generate shortcuts
│   ├── run_once_99-post-install-message.sh
│   └── run_once_after_*.tmpl  # Templates for SSH & encryption
├── .chezmoitemplates/         # Reusable template snippets
├── dot_config/                # Maps to ~/.config/
│   ├── dunst/                 # Notification daemon
│   ├── fontconfig/            # Font rendering settings
│   ├── i3/                    # i3wm configuration
│   ├── i3status/              # Status bar configuration
│   ├── kitty/                 # Terminal emulator
│   ├── nvim/                  # Neovim (LazyVim) setup
│   ├── picom/                 # Compositor for transparency
│   ├── rofi/                  # Application launcher
│   └── shortcuts/             # Centralized shortcuts system
│       └── shortcuts.lua      # All keybindings and aliases definition
├── dot_local/bin/             # Maps to ~/.local/bin/
│   ├── executable_brightness-control
│   ├── executable_github-setup
│   ├── executable_shortcuts-generate  # Generate configs from shortcuts.lua
│   ├── executable_shortcuts-help      # Display shortcuts overlay
│   └── executable_tmux-sessionizer
├── dot_gitconfig.tmpl         # Git configuration with templates
├── dot_tmux.conf              # Tmux multiplexer config
├── dot_zshrc                  # Zsh shell configuration
├── .chezmoi.toml.tmpl         # Chezmoi configuration
├── .chezmoiignore             # Files to exclude from home
└── .chezmoiremove             # Cleanup old files on apply
```

### Chezmoi Naming Conventions
- **`dot_*`** - Files/directories that become `.*` in home directory
- **`executable_*`** - Files that need execute permissions
- **`*.tmpl`** - Template files processed by chezmoi
- **`*.age`** - Encrypted files requiring age key
- **`run_onchange_*`** - Scripts that run when content changes
- **`run_once_*`** - Scripts that run only once per machine
- **`private_*`** - Files with 600 permissions (unused currently)

### Security Architecture
- Age encryption protects SSH keys and sensitive configs
- Encryption key stored at `~/.config/chezmoi/key.txt`
- Recipients configured in `.chezmoi.toml.tmpl`

### Automation Flow
1. Package installation (`00-install-packages.sh`)
2. Font installation (`10-install-nerd-font.sh`)
3. SSH key generation (`20-generate-ssh-key.sh.tmpl`)
4. Age encryption setup (`30-setup-age-encryption.sh`)
5. Shortcuts generation (`50-generate-shortcuts.sh`) - Auto-generates keybindings
6. Post-install instructions (`99-post-install-message.sh`)

### OS Detection
- Scripts use `chezmoi.os` and `chezmoi.osRelease.id` for OS detection
- Package installation scripts are optimized for Arch Linux

## Critical Implementation Notes

- Always use `chezmoi add` instead of directly editing files in the repository
- Test scripts locally before committing, especially package installation scripts
- Encrypted files must have corresponding `.age` extension
- Template variables available: `{{ .chezmoi.username }}`, `{{ .email }}`, etc.
- Scripts in `.chezmoiscripts/` must be idempotent
- `run_onchange_` scripts rerun when their content changes (useful for package lists)
- `run_once_` scripts only run once per machine
- Scripts are executed in alphabetical order

## Shortcuts System

The repository implements a centralized shortcuts management system:

### Architecture
- **Definition**: All keybindings and aliases defined in `~/.config/shortcuts/shortcuts.lua`
- **Generation**: `shortcuts-generate` creates config files for tmux, i3, and shell
- **Auto-update**: Changes trigger regeneration via `run_onchange_50-generate-shortcuts.sh`
- **Help overlay**: `shortcuts-help` displays all shortcuts (accessible via Alt+Shift+? universally)

### Generated Files
- `~/.config/shortcuts/generated/tmux-keybindings.conf` - Sourced by tmux.conf
- `~/.config/shortcuts/generated/i3-keybindings.conf` - Included by i3/config
- `~/.config/shortcuts/generated/shell-aliases.sh` - Sourced by .zshrc

### Adding/Modifying Shortcuts
1. Edit `dot_config/shortcuts/shortcuts.lua`
2. Run `chezmoi apply` (auto-generates configs)
3. Reload affected applications

### Viewing Shortcuts
The `shortcuts-help` command now supports multiple display backends:

```bash
shortcuts-help              # Auto-detect best backend
shortcuts-help fzf          # Interactive search with fzf
shortcuts-help terminal     # Paged view with bat/less
shortcuts-help rofi         # GUI popup (original)
shortcuts-help fzf tmux     # Filter to show only tmux shortcuts
shortcuts-help terminal i3  # Show only i3 shortcuts in terminal
```

Features:
- **FZF mode**: Real-time search with `/`, interactive navigation
- **Terminal mode**: Color-coded, paginated view for SSH sessions
- **Auto-detection**: Picks best backend based on environment
- **Filtering**: Show shortcuts for specific applications

## Vim Mode Configuration

### ZSH Vi Mode
The shell now uses vi-mode for command line editing:
- `ESC`: Enter normal mode
- `i`, `a`, `I`, `A`: Various insert modes
- `h`, `j`, `k`, `l`: Navigate in normal mode
- `w`, `b`, `0`, `$`: Word and line movement
- `dd`, `cw`, `x`: Editing commands
- `u`, `Ctrl+r`: Undo/redo

### Kitty Terminal Vim Bindings
Kitty now includes vim-style navigation:
- **Scrolling**: `Alt+j/k` (line), `Alt+d/u` (page), `Alt+g/G` (top/bottom)
- **Window Navigation**: `Alt+h/j/k/l` to move between panes
- **Tab Navigation**: `Alt+Shift+h/l` for previous/next tab
- **Scrollback**: `Alt+Shift+v` opens scrollback in nvim

## Recent Changes (for Claude Code context)

- Removed all macOS support - now Arch Linux only
- Removed i3lock from packages and configuration
- Added snacks.nvim configuration to show dotfiles by default
- Migrated from `run_once_` to `run_onchange_` for package/font scripts
- Added `.chezmoiignore` to exclude documentation from home directory
- Added `.chezmoiremove` to clean up old macOS configurations
- Added centralized shortcuts system with auto-generation
- Added `shortcuts-help` - Multi-backend display system (fzf, terminal, rofi)
- Added vim mode support for zsh (vi-mode plugin) and kitty terminal
- Enhanced shortcuts display with search and filtering capabilities

