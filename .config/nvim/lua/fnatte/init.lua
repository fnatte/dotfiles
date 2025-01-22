-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load custom settings.
-- Note that lazy must be loaded after kepmap because the <leader> key must be
-- set before lazy is loaded.
require("fnatte.general")
require("fnatte.commands")
require("fnatte.keymap")
require("lazy").setup({
  spec = {
    import = "fnatte/plugins",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin",
        "tohtml",
      },
    },
  },
})

-- Must be loaded after lazy because it depends on plenary.
require("fnatte.gitcommit")

require("fnatte.copilot")
