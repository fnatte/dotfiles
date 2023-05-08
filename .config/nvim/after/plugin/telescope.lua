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
local builtin = require('telescope.builtin')
local keymap = require("fnatte.keymap")
keymap.set('n', '<leader><leader>', builtin.buffers, { desc = "Find Buffers" })
keymap.set('n', '<leader>ff', function() builtin.find_files({previewer = false}) end, { desc = "Find Files" })
keymap.set('n', '<leader>fb', function() builtin.current_buffer_fuzzy_find({ previewer = false }) end, { desc = "Search Current File" })
keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Search String" })
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
keymap.set('n', '<leader>ft', builtin.tags, { desc = "Find Tags" })
keymap.set('n', '<leader>fo', function() builtin.tags{ only_current_buffer = true } end, { desc = "Find Tags in Current Buffer" })
keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find Help Tags" })
