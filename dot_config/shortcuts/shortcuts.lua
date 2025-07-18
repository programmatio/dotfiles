-- Centralized shortcuts configuration
-- Single source of truth for all keybindings and aliases

local M = {}

-- TMUX Configuration
M.tmux = {
  prefix = "C-a",
  
  bindings = {
    -- Format: key = { description, command, options }
    ["C-f"]   = { "Open tmux sessionizer", "run-shell tmux-sessionizer" },
    ["|"]     = { "Split vertically", "split-window -h", prefix = true },
    ["-"]     = { "Split horizontally", "split-window -v", prefix = true },
    ["r"]     = { "Reload config", "source-file ~/.tmux.conf \\; display-message 'Config reloaded!'", prefix = true },
    ["M-?"]   = { "Show shortcuts help (Alt+Shift+?)", "display-popup -E -w 80 -h 40 -T '⌨️ Shortcuts Help' 'shortcuts-help'" },
    
    -- Pane navigation
    ["h"]     = { "Navigate left", "select-pane -L", prefix = true },
    ["j"]     = { "Navigate down", "select-pane -D", prefix = true },
    ["k"]     = { "Navigate up", "select-pane -U", prefix = true },
    ["l"]     = { "Navigate right", "select-pane -R", prefix = true },
    
    -- Smart navigation (works with vim)
    ["C-h"]   = { "Navigate left (vim-aware)", "run-shell 'tmux-navigate left'" },
    ["C-j"]   = { "Navigate down (vim-aware)", "run-shell 'tmux-navigate down'" },
    ["C-k"]   = { "Navigate up (vim-aware)", "run-shell 'tmux-navigate up'" },
    ["C-l"]   = { "Navigate right (vim-aware)", "run-shell 'tmux-navigate right'" },
    
    -- Pane resizing
    ["H"]     = { "Resize left 5", "resize-pane -L 5", prefix = true },
    ["J"]     = { "Resize down 5", "resize-pane -D 5", prefix = true },
    ["K"]     = { "Resize up 5", "resize-pane -U 5", prefix = true },
    ["L"]     = { "Resize right 5", "resize-pane -R 5", prefix = true },
    
    -- Window management
    ["C-p"]   = { "Previous window", "previous-window" },
    ["C-n"]   = { "Next window", "next-window" },
    ["c"]     = { "Create window", "new-window", prefix = true },
    [","]     = { "Rename window", "rename-window", prefix = true },
    ["&"]     = { "Kill window", "kill-window", prefix = true },
    ["x"]     = { "Kill pane", "kill-pane", prefix = true },
    ["d"]     = { "Detach session", "detach-client", prefix = true },
  }
}

-- i3 Window Manager
M.i3 = {
  mod = "mod",  -- Uses $mod from i3 config (Alt key)
  
  bindings = {
    -- Format: key = { description, command }
    ["Return"]      = { "Open terminal", "exec kitty" },
    ["d"]           = { "App launcher", "exec --no-startup-id rofi -show drun" },
    ["Ctrl+Shift+question"] = { "Show shortcuts help (Ctrl+?)", "exec shortcuts-help", no_mod = true },
    ["Shift+q"]     = { "Close window", "kill" },
    ["Shift+r"]     = { "Restart i3", "restart" },
    ["Shift+e"]     = { "Exit i3", 'exec "i3-nagbar -t warning -m \\"Exit i3?\\" -B \\"Yes\\" \\"i3-msg exit\\""' },
    
    -- Navigation
    ["h"]           = { "Focus left", "focus left" },
    ["j"]           = { "Focus down", "focus down" },
    ["k"]           = { "Focus up", "focus up" },
    ["l"]           = { "Focus right", "focus right" },
    ["Shift+h"]     = { "Move left", "move left" },
    ["Shift+j"]     = { "Move down", "move down" },
    ["Shift+k"]     = { "Move up", "move up" },
    ["Shift+l"]     = { "Move right", "move right" },
    
    -- Layout
    ["f"]           = { "Fullscreen", "fullscreen toggle" },
    ["e"]           = { "Toggle split", "layout toggle split" },
    ["s"]           = { "Stacking", "layout stacking" },
    ["w"]           = { "Tabbed", "layout tabbed" },
    ["space"]       = { "Toggle floating", "floating toggle" },
    ["Shift+space"] = { "Focus mode toggle", "focus mode_toggle" },
    ["a"]           = { "Focus parent", "focus parent" },
    
    -- Workspaces (generated programmatically to avoid repetition)
    -- See M.i3.workspaces below
  },
  
  -- Generate workspace bindings programmatically
  workspaces = function()
    local ws = {}
    for i = 1, 10 do
      local key = tostring(i % 10)  -- 10 becomes 0
      local num = tostring(i)
      ws[key] = { "Switch to workspace " .. num, "workspace number " .. num }
      ws["Shift+" .. key] = { "Move to workspace " .. num, "move container to workspace number " .. num }
    end
    return ws
  end
}

-- Kitty Terminal
M.kitty = {
  bindings = {
    -- Vim-style scrolling
    ["alt+k"] = { "Scroll line up", "scroll_line_up" },
    ["alt+j"] = { "Scroll line down", "scroll_line_down" },
    ["alt+u"] = { "Scroll page up", "scroll_page_up" },
    ["alt+d"] = { "Scroll page down", "scroll_page_down" },
    ["alt+g"] = { "Scroll to top", "scroll_home" },
    ["alt+shift+g"] = { "Scroll to bottom", "scroll_end" },
    
    -- Vim-style window navigation
    ["alt+h"] = { "Navigate window left", "neighboring_window left" },
    ["alt+l"] = { "Navigate window right", "neighboring_window right" },
    ["alt+j"] = { "Navigate window down", "neighboring_window down" },
    ["alt+k"] = { "Navigate window up", "neighboring_window up" },
    
    -- Tab navigation
    ["alt+shift+h"] = { "Previous tab", "previous_tab" },
    ["alt+shift+l"] = { "Next tab", "next_tab" },
    
    -- Scrollback
    ["alt+shift+v"] = { "Open scrollback in nvim", "show_scrollback" },
  }
}

-- ZSH Vi Mode
M.zsh_vi_mode = {
  description = "ZSH vi-mode plugin enabled",
  bindings = {
    ["ESC"] = { "Enter normal mode", "Enter vim normal mode for command line editing" },
    ["i"] = { "Enter insert mode", "Enter vim insert mode (in normal mode)" },
    ["a"] = { "Append", "Move cursor forward and enter insert mode (in normal mode)" },
    ["A"] = { "Append at end", "Move to end of line and enter insert mode (in normal mode)" },
    ["I"] = { "Insert at beginning", "Move to beginning and enter insert mode (in normal mode)" },
    
    -- Navigation (in normal mode)
    ["h"] = { "Move left", "Move cursor left (in normal mode)" },
    ["l"] = { "Move right", "Move cursor right (in normal mode)" },
    ["w"] = { "Next word", "Move to next word (in normal mode)" },
    ["b"] = { "Previous word", "Move to previous word (in normal mode)" },
    ["0"] = { "Beginning of line", "Move to beginning of line (in normal mode)" },
    ["$"] = { "End of line", "Move to end of line (in normal mode)" },
    
    -- Editing (in normal mode)
    ["dd"] = { "Delete line", "Delete entire line (in normal mode)" },
    ["dw"] = { "Delete word", "Delete word (in normal mode)" },
    ["cw"] = { "Change word", "Change word (in normal mode)" },
    ["x"] = { "Delete char", "Delete character (in normal mode)" },
    ["r"] = { "Replace char", "Replace character (in normal mode)" },
    ["u"] = { "Undo", "Undo last change (in normal mode)" },
    ["Ctrl+r"] = { "Redo", "Redo last undo (in normal mode)" },
  }
}

-- Shell Aliases
M.aliases = {
  -- Format: alias = command (description in comments for help display)
  nav = {
    ll  = "ls -alF",        -- List files (detailed)
    la  = "ls -A",          -- List all files  
    l   = "ls -CF",         -- List files (compact)
    [".."] = "cd ..",       -- Go up one directory
    ["..."] = "cd ../..",   -- Go up two directories
  },
  
  git = {
    gs  = "git status",     -- Git status
    gc  = "git commit",     -- Git commit
    gp  = "git push",       -- Git push
    gpl = "git pull",       -- Git pull
    gco = "git checkout",   -- Git checkout
    gb  = "git branch",     -- Git branch
    ga  = "git add",        -- Git add
    gd  = "git diff",       -- Git diff
    gl  = "git log --oneline --graph --decorate",  -- Git log (graph)
  },
  
  tmux = {
    ta   = "tmux attach -t",      -- Attach to session
    tad  = "tmux attach -d -t",   -- Attach (detach others)
    ts   = "tmux new-session -s", -- New session
    tl   = "tmux list-sessions",  -- List sessions
    tkss = "tmux kill-session -t", -- Kill session
    tksv = "tmux kill-server",    -- Kill server
  },
  
  apps = {
    v       = "nvim",       -- Neovim
    vi      = "nvim",       -- Neovim
    vim     = "nvim",       -- Neovim
    browser = "chromium",   -- Browser
  },
}

-- Merge workspace bindings into i3
for k, v in pairs(M.i3.workspaces()) do
  M.i3.bindings[k] = v
end

return M