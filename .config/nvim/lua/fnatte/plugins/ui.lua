return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        dark_variant = 'moon',
      })
      vim.cmd('colorscheme rose-pine')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'ColorScheme',
    config = function()
      require('lualine').setup({ options = { theme = 'rose-pine' } })
    end
  },
}
