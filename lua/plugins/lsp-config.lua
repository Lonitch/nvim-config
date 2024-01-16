return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- define LSP servers here for LUA, RUST, and JS/TS
        ensure_installed = { "lua_ls", "rust_analyzer", "tsserver" }
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        filetypes = {"rust"},
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
          },
        },
      })
      -- Global mappings
      -- <space> + s to show documentation of hovered word
      vim.keymap.set('n', '<leader>s', vim.lsp.buf.hover, {})
      -- <space>+g+d: go to definition
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      -- <space>+c+a: selects a code action available at the current position
      vim.keymap.set('n','<leader>a', vim.lsp.buf.code_action, {})
    end,
  },
  }
