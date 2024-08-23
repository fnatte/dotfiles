return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',             -- Github for GBrowse
  'shumphrey/fugitive-gitlab.vim', -- Gitlab for GBrowse

  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup({
        current_line_blame = true
      })
    end,
  }
}
