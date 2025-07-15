return {
  -- Tailwind CSS colorizer for nvim-cmp
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- only load when tailwindcss-language-server is active
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte", "astro" },
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  -- Configure nvim-cmp to use tailwindcss-colorizer-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Add tailwindcss-colorizer-cmp formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        if format_kinds then
          format_kinds(entry, item)
        end
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
}