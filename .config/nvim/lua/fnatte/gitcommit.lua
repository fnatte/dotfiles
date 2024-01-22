local Job = require("plenary.job")

local function addIssueIdToCommitMsg()
    Job:new({
        command = "git",
        args = {"branch", "--show-current"},
        on_exit = function(j, return_val)
            local branchName = j:result()[1]
            if return_val == 0 and branchName then
                -- Pattern to match issue ID (e.g., ABC-1234)
                local issueId = branchName:match("(%w+-%d+)")
                if issueId then
                    vim.schedule(function()
                        local bufnr = vim.api.nvim_get_current_buf()
                        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                        table.insert(lines, 1, "")
                        table.insert(lines, 2, "")
                        table.insert(lines, 3, "Refs: " .. issueId)
                        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

                        -- Set cursor to the first line
                        local win = vim.api.nvim_get_current_win()
                        vim.api.nvim_win_set_cursor(win, {1, 0})
                    end)
                end
            end
        end,
    }):start()
end

-- Set up the autocommand
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        addIssueIdToCommitMsg()
    end
})

