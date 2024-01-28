local keymap = {}

vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- Map capital wq letters to lowercase because of typos
vim.cmd([[
  command! WQ wq
  command! Wq wq
  command! W w
  command! Q q
]])

function keymap.set(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend("error", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Make double-<Esc> clear search highlights and close preview window
keymap.set('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR><Esc>:pc<CR>:ccl<CR>')

-- Use tab/shift-tab to navigate between buffers
keymap.set('n', '<S-TAB>', ':bnext<CR>')
keymap.set('n', '<TAB>', ':bprevious<CR>')

-- Move selected lines up/down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when screen scrolling up/down
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Toggle background color with <leader>bg
keymap.set("n", "<leader>bg", function()
    if vim.o.background == 'dark' then
      vim.o.background = 'light'
    else
      vim.o.background = 'dark'
    end
  end,
  { desc = "Toggle Background Color" }
)

return keymap
