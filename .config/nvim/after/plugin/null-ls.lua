require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.eslint.with({
            condition = function(utils)
                return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" })
            end,
        }),
        require("null-ls").builtins.completion.spell.with({
            filetypes = { "markdown", "text" },
        }),
    },
})
