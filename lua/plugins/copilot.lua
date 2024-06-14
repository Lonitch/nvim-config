return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          keymap = {
            accept = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    config = function()
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup()
    end,
  },
}
