local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local M = {}

local prettier = require("efmls-configs.formatters.prettier")
local prettier_d = require("efmls-configs.formatters.prettier_d")
local lint_eslint_d = require("efmls-configs.linters.eslint_d")

local languages = {
  lua = {
    require("efmls-configs.formatters.stylua"),
    require("efmls-configs.linters.luacheck"),
  },

  python = {
    require("efmls-configs.linters.flake8"),
    require("efmls-configs.formatters.black"),
  },

  html = { prettier_d },
  markdown = { prettier_d },

  javascript = {
    prettier_d,
    lint_eslint_d,
  },
  javascriptreact = {
    prettier_d,
    lint_eslint_d,
  },
  typescript = {
    prettier_d,
    lint_eslint_d,
  },
  typescriptreact = {
    prettier_d,
    lint_eslint_d,
  },
  json = {
    prettier,
  },
  css = {
    prettier_d,
  },

  rust = {
    require("efmls-configs.formatters.rustfmt"),
  },

  php = {
    require('efmls-configs.formatters.php_cs_fixer'),
  }
}

M.setup = function(on_attach, capabilities)
  lspconfig.efm.setup({
    filetypes = vim.tbl_keys(languages),
    settings = {
      rootMarkers = { ".git/" },
      languages = languages,
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
    },
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
