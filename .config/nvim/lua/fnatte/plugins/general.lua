return {
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-abolish',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'wellle/targets.vim',
  'arthurxavierx/vim-caser',

  {
    -- Show vertical line for indention
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        scope = {
          enabled = false,
        },
      })
    end,
  }
}
