return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()

      vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>Oil<CR>", { noremap = true, silent = true })
    end,
  },
}
