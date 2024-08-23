local config = function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "vimdoc", "javascript", "typescript", "lua", "markdown" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    ignore_install = {},

    modules = {},

    highlight = {
      enable = true,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = 'grn',
        scope_incremental = 'grc',
        node_decremental = 'grm',
      },
    },

    indent = {
      enable = true,
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
    },

    folding = {
      enable = true,
    }
  }

  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.textadventuremap = {
    install_info = {
      url = "~/Code/games/text-adventure/tree-sitter-text-adventure-map", -- local path or git repo
      files = { "src/parser.c" },                                       -- note that some parsers also require src/scanner.c or src/scanner.cc
      -- optional entries:
      branch = "main",                                                  -- default branch in case of git repo if different from master
      generate_requires_npm = false,                                    -- if stand-alone parser without npm dependencies
      requires_generate_from_grammar = false,                           -- if folder contains pre-generated src/parser.c
    },
    filetype = "textadventuremap",                                      -- if filetype does not match the parser name
  }
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = config,
  },
}
