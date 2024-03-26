local zen_mode = require('zen-mode')

zen_mode.setup({
  window = {
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },

  plugins = {
    gitsigns = { enabled = true },
    tmux = { enabled = true },
    kitty = {
      enabled = true,
      font = "+4", -- font size increment
    },
  },

  on_open = function()
    vim.cmd("IBLDisable")
  end,

  on_close = function()
    vim.cmd("IBLEnable")
  end,
})

vim.keymap.set('n', '<leader>z', zen_mode.toggle, { silent = true })

