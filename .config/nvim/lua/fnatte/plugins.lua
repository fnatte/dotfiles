local textFts = {'markdown', 'plaintex', 'tex', 'text'}

return {
  -- General
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-abolish',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-fugitive', -- Git
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  'wellle/targets.vim',
  'arthurxavierx/vim-caser',

  -- Look
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
    config = function()
      require('lualine').setup({ options = { theme = 'rose-pine' } })
    end
  },
  "lukas-reineke/indent-blankline.nvim", -- Show vertical line for indention

  -- File Explorer
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' } },

  -- Writing
  { 'reedes/vim-pencil', ft = textFts },
  'folke/zen-mode.nvim',
  'folke/twilight.nvim', -- Dim inactive code during zen mode

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- LSP Support
  'neovim/nvim-lspconfig',
  { 'williamboman/mason.nvim', build = ':MasonUpdate' },
  'williamboman/mason-lspconfig.nvim',
  'mfussenegger/nvim-dap',
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
  { "creativenull/efmls-configs-nvim", dependencies = { "neovim/nvim-lspconfig" } },

  -- Auto Completion
  'github/copilot.vim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',

  -- Snippets
  'L3MON4D3/LuaSnip',

  -- Others
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },

  -- LLM
  'David-Kunz/gen.nvim',
}
