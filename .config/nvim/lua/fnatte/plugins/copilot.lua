return {
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_filetypes = {
        gitcommit = true,

        TelescopeResults = false,
        TelescopePrompt = false,
        NvimTree = false,
        NvimTreeNormal = false,
        NvimTreeEndOfBuffer = false,
        NvimTreeVertSplit = false,
        NvimTreeStatusLine = false,
        NvimTreeStatusLineNC = false,
      }
    end
  }
}
