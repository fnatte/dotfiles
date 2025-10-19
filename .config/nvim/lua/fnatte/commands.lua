vim.api.nvim_create_user_command(
  'CloseBuffersExceptCurrent',
  function(opts)
    -- Store cursor position
    local cursor = vim.fn.getpos('.')

    -- Close all buffers, open the last buffer, then close the [No Name] buffer
    -- that was automatically opened when all buffers were closed.
    vim.cmd [[
      %bd|e#|bd#
    ]]

    -- Restore cursor position
    vim.fn.setpos('.', cursor)
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command("YankFilePath", function()
  local path = vim.fn.expand("%") -- relative to cwd
  vim.fn.setreg("+", path)
  vim.fn.setreg('"', path)
  print("Yanked: " .. path)
end, {})
