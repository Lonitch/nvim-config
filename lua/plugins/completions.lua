return {
  {
    "davidhalter/jedi-vim",
    config = function()
      _G.jedi_vim_init = function()
        vim.api.nvim_set_var("jedi#completions_enabled", 0)
        vim.api.nvim_set_var("jedi#auto_initialization", 0)
        vim.api.nvim_set_var("jedi#auto_vim_configuration", 0)
        vim.api.nvim_set_var("jedi#smart_auto_mappings", 0)
        vim.cmd("call jedi#init_python()")
      end

      vim.cmd([[
      augroup jedi_vim_autocmd
        autocmd!
        autocmd FileType python ++once lua jedi_vim_init()
      augroup END
    ]])
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "jedi_vim" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
