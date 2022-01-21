-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Add leader shortcuts
local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
map('n', '<leader><leader>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opt)
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({ previewer = false })<CR>]], opt)
map('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opt)
map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
map('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opt)
map('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opt)
map('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
