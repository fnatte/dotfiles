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

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when screen scrolling up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Toggle background color with <leader>bg
vim.keymap.set("n", "<leader>bg", function()
    if vim.o.background == 'dark' then
      vim.o.background = 'light'
    else
      vim.o.background = 'dark'
    end
  end,
  {noremap = true, silent = true}
)

