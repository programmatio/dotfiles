# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by chezmoi, providing automated setup for development environments on Arch Linux and macOS. The repository uses age encryption for sensitive files and includes automated package installation and configuration.

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

### Chezmoi Structure
- **`.chezmoiscripts/`** - Run-once setup scripts executed in alphabetical order
- **`.chezmoitemplates/`** - Reusable template fragments
- **`dot_*`** - Files/directories that become `.*` in home directory
- **`*.tmpl`** - Template files processed by chezmoi
- **`*.age`** - Encrypted files requiring age key

### Security Architecture
- Age encryption protects SSH keys and sensitive configs
- Encryption key stored at `~/.config/chezmoi/key.txt`
- Recipients configured in `.chezmoi.toml.tmpl`

### Automation Flow
1. Package installation (`00-install-packages.sh`)
2. Font installation (`10-install-nerd-font.sh`)
3. SSH key generation (`20-generate-ssh-key.sh.tmpl`)
4. Age encryption setup (`30-setup-age-encryption.sh`)
5. Post-install instructions (`99-post-install-message.sh`)

### Cross-Platform Handling
- Scripts detect OS using `chezmoi.os` and `chezmoi.osRelease.id`
- Conditional package installation for Arch vs macOS
- Platform-specific configurations in templates

## Critical Implementation Notes

- Always use `chezmoi add` instead of directly editing files in the repository
- Test scripts locally before committing, especially package installation scripts
- Encrypted files must have corresponding `.age` extension
- Template variables available: `{{ .chezmoi.username }}`, `{{ .email }}`, etc.
- Scripts in `.chezmoiscripts/` must be idempotent due to `run_once_` prefix

## macOS Window Management (Yabai/SKHD)

### Configuration Files
- **`dot_config/yabai/executable_yabairc`** - Yabai window manager config (mimics i3)
- **`dot_config/skhd/skhdrc`** - Hotkey daemon config (replicates i3 keybindings)
- **`dot_config/sketchybar/`** - Status bar configuration (mimics i3bar)

### Key Differences from i3
- Uses Alt (Option) as modifier key to match i3 config
- Binary Space Partitioning (BSP) instead of i3's manual tiling
- macOS "Spaces" instead of i3 workspaces
- Some features require partial SIP disable (borders, opacity)

### Testing Yabai/SKHD Changes
```bash
# Reload configurations
yabai --restart-service
skhd --restart-service
brew services restart sketchybar

# Debug issues
tail -f /tmp/yabai_*.err.log
tail -f /tmp/skhd_*.err.log
```