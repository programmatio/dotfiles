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

### i3 Window Manager (Mod = Alt key)
- `Mod+Return` - Open terminal (Kitty)
- `Mod+d` - Application launcher (Rofi)
- `Mod+h/j/k/l` - Navigate windows
- `Mod+Shift+h/j/k/l` - Move windows
- `Ctrl+1-0` - Switch workspaces (Alt+1-0 also works)
- `Mod+Shift+f` - Fullscreen toggle
- `Mod+x` - Lock screen

### Mac-like Keybindings (Cmd = Super/Windows key)
**Text Editing:**
- `Cmd+A` - Select all
- `Cmd+C` - Copy
- `Cmd+X` - Cut  
- `Cmd+V` - Paste
- `Cmd+Z` - Undo
- `Cmd+Shift+Z` - Redo
- `Cmd+S` - Save
- `Cmd+Shift+S` - Save as
- `Cmd+O` - Open
- `Cmd+F` - Find
- `Cmd+G` - Find next
- `Cmd+Shift+G` - Find previous
- `Cmd+P` - Print
- `Cmd+N` - New

**Navigation:**
- `Cmd+Left/Right` - Home/End
- `Cmd+Up/Down` - Document start/end
- `Cmd+Shift+Arrow` - Select to line/document boundaries
- `Alt+Left/Right` - Word navigation
- `Alt+Shift+Left/Right` - Select word
- `Alt+Backspace` - Delete word backward
- `Alt+Delete` - Delete word forward

**Browser/Tabs:**
- `Cmd+T` - New tab
- `Cmd+W` - Close tab
- `Cmd+Shift+T` - Reopen closed tab
- `Cmd+Tab` - Next tab
- `Cmd+Shift+Tab` - Previous tab
- `Cmd+1-9` - Switch to tab 1-9
- `Cmd+L` - Focus address bar
- `Cmd+R` - Reload
- `Cmd+Shift+R` - Hard reload
- `Cmd+D` - Bookmark
- `Cmd+[/]` - Back/Forward
- `Cmd+Return` - Open in new tab
- `Cmd+Shift+Return` - Open in new window

**Window/Application:**
- `Cmd+Q` - Quit application
- `Cmd+M` - Minimize
- `Cmd+H` - Hide window
- `Cmd+,` - Preferences

**Developer:**
- `Cmd+/` - Toggle comment
- `Cmd+Shift+/` - Block comment
- `Cmd+K` - Clear/Delete line
- `Cmd+B` - Bold
- `Cmd+I` - Italic
- `Cmd+U` - Underline
- `Cmd+Shift+I` - Developer tools
- `Cmd+Shift+C` - Inspect element
- `Cmd+Shift+J` - Console

**Other:**
- `Cmd+Plus/Minus` - Zoom in/out
- `Cmd+0` - Reset zoom
- `Cmd+.` - Cancel (Escape)
- `Cmd+Space` - Language switch

**Terminal-specific overrides:**
- `Cmd+C` - Copy (Ctrl+Shift+C in terminal)
- `Cmd+V` - Paste (Ctrl+Shift+V in terminal)

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