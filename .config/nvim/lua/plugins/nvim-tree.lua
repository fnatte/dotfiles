require'nvim-tree'.setup {}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })

