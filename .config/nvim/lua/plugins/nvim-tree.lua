require'nvim-tree'.setup {
  view = {
    width = '100%',
  },
  actions = {
    open_file = {
      quit_on_open = 1,
    }
  }
}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })

