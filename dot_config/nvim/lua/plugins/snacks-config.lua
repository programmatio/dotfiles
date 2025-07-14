return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,  -- Show hidden files (dotfiles) by default
          ignored = false, -- Don't show git-ignored files by default
        },
      },
    },
  },
  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
  },
}