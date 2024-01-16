return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- <space>+n to open/close file tree
    vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left toggle<CR>", {})
    -- <space>+b+o to reveal opened files 
    vim.keymap.set("n", "<leader>bo", ":Neotree buffers reveal float<CR>", {})
  end,
}
