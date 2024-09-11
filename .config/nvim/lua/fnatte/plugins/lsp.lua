local config = function()
  -- LSP settings
  require('mason').setup()
  require('mason-lspconfig').setup()
  local lspconfig = require('lspconfig')

  local keymap = require("fnatte.keymap")
  keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open Diagnostic" })
  keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
  keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
  keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open Diagnostic Location List" })

  local lsp_format = function()
    vim.lsp.buf.format { filter = function(client) return client.name ~= "ts_ls" end }
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

  -- nvim-cmp supports additional completion capabilities.
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local handlers = {
    -- default handler
    function(server_name)
      require("lspconfig")[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,

    -- Typescript
    ["ts_ls"] = function()
      lspconfig.ts_ls.setup {
        -- Make sure that ts_ls is not in conflict with deno
        root_dir = lspconfig.util.root_pattern("package.json"),
        on_attach = on_attach,
        capabilities = capabilities,
        single_file_support = false,
        init_options = {
          lint = true,
        },
      }
    end,

    -- Deno
    ["denols"] = function()
      lspconfig.denols.setup {
        -- Make sure that denols is not in conflict with ts_ls
        root_dir = lspconfig.util.root_pattern("deno.json"),
        on_attach = on_attach,
        capabilities = capabilities,
        single_file_support = false,
        init_options = {
          lint = true,
        },
      }
    end,

    -- Clang
    ["clangd"] = function()
      lspconfig.clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        -- Do not run clangd for proto files
        filetypes = { "c", "cpp", "objc", "objcpp" },
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      }
    end,

    -- C#
    ["omnisharp"] = function()
      lspconfig.omnisharp.setup {
        -- Required because semantic tokens do not conform to the LSP specification
        -- See https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
        on_attach = function(client, bufnr)
          local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
          for i, v in ipairs(tokenModifiers) do
            tokenModifiers[i] = v:gsub(' ', '_')
          end
          local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
          for i, v in ipairs(tokenTypes) do
            tokenTypes[i] = v:gsub(' ', '_')
          end

          on_attach(client, bufnr)
        end,
        capabilities = capabilities,

        -- Hides Omnisharp info diagnostic messages
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              virtual_text = {
                severity = vim.diagnostic.severity.INFO,
                spacing = 4,
              },
            }
          ),
        },

        settings = {
          FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = nil,
          },
          MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            LoadProjectsOnDemand = nil,
          },
          RoslynExtensionsOptions = {
            -- Enables support for roslyn analyzers, code fixes and rulesets.
            EnableAnalyzersSupport = true,
            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            EnableImportCompletion = true,
            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            AnalyzeOpenDocumentsOnly = nil,
          },
          Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
          },
        },
      }
    end,

    -- Lua
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" }
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },

            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },

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
      }
    end,

    ['rust_analyzer'] = function()
      lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
            }
          }
        }
      }
    end,

    ['sqls'] = function()
      lspconfig.sqls.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          require('sqls').on_attach(client, bufnr)

          local bufopts = { buffer = bufnr, desc = "Execute Query" }
          keymap.set('n', '<leader>se', '<Plug>(sqls-execute-query)', bufopts)
          keymap.set('x', '<leader>se', '<Plug>(sqls-execute-query)', bufopts)
          keymap.set('x', '<CR>', '<Plug>(sqls-execute-query)', bufopts)
        end,
      }
    end,

    ['gopls'] = function()
      lspconfig.gopls.setup {
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
      }
    end,

    ['pyright'] = function()
      lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        on_new_config = function(config, root_dir)
          local env = vim.trim(vim.fn.system('cd "' .. root_dir .. '"; poetry env info -p 2>/dev/null'))
          if string.len(env) > 0 then
            config.settings.python.pythonPath = env .. '/bin/python'
          end
        end
      }
    end
  }

  require("mason-lspconfig").setup_handlers(handlers)
  require("fnatte.lsp.efm").setup(on_attach, capabilities)
end

return {
  {
    'neovim/nvim-lspconfig',
    config = config,
    dependencies = {
      'nanotee/sqls.nvim',
      "creativenull/efmls-configs-nvim",
      {
        'williamboman/mason.nvim',
        dependencies = {
          'williamboman/mason-lspconfig.nvim',
        },
        build = ':MasonUpdate'
      },
    },
  },
}
