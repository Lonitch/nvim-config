return {
  "nvimtools/none-ls.nvim",
  config= function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- auto-format lua
        null_ls.builtins.formatting.stylua,
        -- js formatting
        null_ls.builtins.formatting.prettier,
        -- eslint diagnostics
        null_ls.builtins.diagnostics.eslint_d,
        -- spell completion
        null_ls.builtins.completion.spell,
      }
    })
 end,
}
