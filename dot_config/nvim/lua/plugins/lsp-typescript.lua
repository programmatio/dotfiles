return {
  -- Import LazyVim's TypeScript extras for full TypeScript support
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- Configure nvim-cmp for better autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "nvim_lsp_signature_help", priority = 900 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      })
      
      -- Better completion experience
      opts.completion = {
        completeopt = "menu,menuone,noinsert",
      }
      
      -- Show completion item kind icons
      opts.formatting = {
        format = function(entry, vim_item)
          if opts.formatting and opts.formatting.format then
            vim_item = opts.formatting.format(entry, vim_item)
          end
          return vim_item
        end,
      }
      
      return opts
    end,
  },

  -- Enhanced TypeScript LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              suggest = {
                includeCompletionsWithSnippetText = true,
                includeCompletionsWithInsertText = true,
                includeCompletionsWithClassMemberSnippets = true,
                includeCompletionsWithObjectLiteralMethodSnippets = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              suggest = {
                includeCompletionsWithSnippetText = true,
                includeCompletionsWithInsertText = true,
                includeCompletionsWithClassMemberSnippets = true,
                includeCompletionsWithObjectLiteralMethodSnippets = true,
              },
            },
          },
        },
      },
      setup = {
        tsserver = function(_, opts)
          -- Enable organize imports on save
          require("lazyvim.util").lsp.on_attach(function(client, buffer)
            if client.name == "tsserver" then
              vim.keymap.set("n", "<leader>co", function()
                vim.lsp.buf.execute_command({
                  command = "_typescript.organizeImports",
                  arguments = { vim.api.nvim_buf_get_name(0) },
                })
              end, { buffer = buffer, desc = "Organize Imports" })
            end
          end)
        end,
      },
    },
  },

  -- Add typescript.nvim for additional TypeScript functionality
  {
    "jose-elias-alvarez/typescript.nvim",
    lazy = true,
    opts = {
      disable_commands = false,
      debug = false,
      go_to_source_definition = {
        fallback = true,
      },
      server = {
        on_attach = function(client, bufnr)
          -- Disable tsserver formatting in favor of prettier/eslint
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },

  -- Mason - ensure TypeScript tools are installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
      })
    end,
  },
}