return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end,
    opts = {
      dark_variant = 'moon',
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'ColorScheme',
    config = function()
      require('lualine').setup({ options = { theme = 'rose-pine' } })
    end
  },
}
