null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint.with({
            condition = function(utils)
                return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" })
            end,
        }),
        null_ls.builtins.completion.spell.with({
            filetypes = { "markdown", "text" },
        }),
    },
})
