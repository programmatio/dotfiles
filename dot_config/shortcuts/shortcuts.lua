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