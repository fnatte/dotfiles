vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- Map capital wq letters to lowercase because of typos
vim.cmd([[
  command! WQ wq
  command! Wq wq
  command! W w
  command! Q q
]])

-- Make double-<Esc> clear search highlights and close preview window
vim.api.nvim_set_keymap('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR><Esc>:pc<CR>:ccl<CR>',
  { noremap = true, silent = true })
