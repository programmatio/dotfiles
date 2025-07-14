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

### OS Detection
- Scripts use `chezmoi.os` and `chezmoi.osRelease.id` for OS detection
- Package installation scripts are optimized for Arch Linux

## Critical Implementation Notes

- Always use `chezmoi add` instead of directly editing files in the repository
- Test scripts locally before committing, especially package installation scripts
- Encrypted files must have corresponding `.age` extension
- Template variables available: `{{ .chezmoi.username }}`, `{{ .email }}`, etc.
- Scripts in `.chezmoiscripts/` must be idempotent due to `run_once_` prefix

