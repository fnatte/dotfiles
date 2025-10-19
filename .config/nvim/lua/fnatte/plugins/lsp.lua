local config = function()
  local keymap = require("fnatte.keymap")
  keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open Diagnostic" })
  keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
  keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
  keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open Diagnostic Location List" })

  local lsp_format = function()
    vim.lsp.buf.format {
      filter = function(client) return client.name ~= "ts_ls" and client.name ~= "tailwindcss" end,
      timeout_ms = 3000
    }
  end

  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { buffer = bufnr }
    keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)

    keymap.set('n', '<leader>f', lsp_format, bufopts)
    keymap.set('v', '<leader>f', lsp_format, bufopts)
    keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    keymap.set('n', '<leader>c', vim.lsp.buf.code_action, bufopts)

    keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    keymap.set('n', '<leader>so', function() require('telescope.builtin').lsp_document_symbols() end, bufopts)
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.config('*', {
    on_attach = on_attach,
    capabilities = capabilities,
    root_markers = { '.git' },
  })

  vim.lsp.config('ts_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      single_file_support = false,
      init_options = {
        lint = true,
      },
    },
  })

  vim.lsp.config('eslint', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      format = { enable = true },
    },
  })

  vim.lsp.config('tailwindcss', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      tailwindCSS = {
      },
    },
  })

  vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          }
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = {
          --   vim.api.nvim_get_runtime_file('', true),
          -- }
        }
      })
    end,
    settings = {
      Lua = {
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },

        -- Formatting defaults
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          }
        },
      }
    }
  })

  vim.lsp.config('clangd', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  })

  vim.lsp.config('rust_analyzer', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      }
    }
  })

  vim.lsp.config('gopls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      gopls = {
        buildFlags = { "-tags=integration,e2e" },
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  })

  vim.lsp.config('pyright', {
    on_attach = on_attach,
    capabilities = capabilities,
    on_new_config = function(config, root_dir)
      local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
      if string.len(env) > 0 then
        config.settings.python.pythonPath = env .. '/bin/python'
      end
    end
  })

  vim.lsp.config('sqls', {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require('sqls').on_attach(client, bufnr)

      local bufopts = { buffer = bufnr, desc = "Execute Query" }
      keymap.set('n', '<leader>se', '<Plug>(sqls-execute-query)', bufopts)
      keymap.set('x', '<leader>se', '<Plug>(sqls-execute-query)', bufopts)
      keymap.set('x', '<CR>', '<Plug>(sqls-execute-query)', bufopts)
    end,
  })

  vim.lsp.enable({ 'ts_ls', 'eslint', 'lua_ls', 'clangd', 'rust_analyzer', 'gopls', 'pyright', 'sqls' })

  vim.lsp.enable( { 'beancount' })

  require('fnatte.lsp.efm').setup(on_attach, capabilities)
end

return {
  {
    'neovim/nvim-lspconfig',
    config = config,
    dependencies = {
      'nanotee/sqls.nvim',
      "creativenull/efmls-configs-nvim",
      {
        "mason-org/mason.nvim",
        opts = {}
      }
    },
  },
}
