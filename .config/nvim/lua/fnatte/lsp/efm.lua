local M = {}

local prettier = require("efmls-configs.formatters.prettier")
local prettier_d = require("efmls-configs.formatters.prettier_d")

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
  },
  javascriptreact = {
    prettier_d,
  },
  typescript = {
    prettier,
  },
  typescriptreact = {
    prettier,
  },
  json = {
    prettier_d,
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
  vim.lsp.config('efm', {
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
