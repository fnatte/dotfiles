vim.o.background = 'dark'
vim.cmd [[colorscheme nordfox]]

vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.hidden = true
vim.opt.timeoutlen = 400
vim.opt.updatetime = 300
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.shell = '/bin/bash' -- nvim-tree.lua has issues with fish shell
vim.opt.clipboard = 'unnamedplus'
vim.opt.conceallevel = 0

-- Disable default plugins
vim.g.loaded_netrwPlugin = 1 

-- Show vertical line for tabs
vim.opt.list = true

-- Highlight current line in current buffer
vim.opt.cursorline = true
vim.cmd([[
  augroup cursorline_current_buffer
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
  augroup end
]])

-- Highlight matching braces etc.
vim.opt.showmatch = true
vim.opt.matchtime = 1
table.insert(vim.opt.matchpairs, "<:>")

-- Show more lines when scrolling
vim.opt.scrolloff = 5

-- Save undo history.
vim.opt.undofile = true

-- Hide the --INSERT-- status text because we show it using lightline status bar
vim.opt.showmode = false

-- Set fold method to use tree sitter expressions
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99

