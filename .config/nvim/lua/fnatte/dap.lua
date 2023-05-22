local dap = require('dap')
local dapui = require('dapui')
local keymap = require("fnatte.keymap")

keymap.set('n', '<leader>dc', dap.continue)
keymap.set('n', '<leader>ds', dap.disconnect)
keymap.set('n', '<leader>dj', dap.step_over)
keymap.set('n', '<leader>dl', dap.step_into)
keymap.set('n', '<leader>dh', dap.step_out)
keymap.set('n', '<leader>db', dap.toggle_breakpoint)
keymap.set('n', '<leader>dr', dap.repl.open)
keymap.set('n', '<leader>dd', dap.run_last)
keymap.set('n', '<leader>du', dapui.toggle)
keymap.set('n', '<F5>', dap.continue)
keymap.set('n', '<F10>', dap.step_over)
keymap.set('n', '<F11>', dap.step_into)
keymap.set('n', '<F12>', dap.step_out)

dapui.setup()

local function get_dll()
  return coroutine.create(function(dap_run_co)
    local items = vim.fn.globpath(vim.fn.getcwd(), '**/bin/Debug/**/*.dll', 0, 1)
    local opts = {
      format_item = function(path)
        return vim.fn.fnamemodify(path, ':t')
      end,
    }
    local function cont(choice)
      if choice == nil then
        return nil
      else
        coroutine.resume(dap_run_co, choice)
      end
    end

    vim.ui.select(items, opts, cont)
  end)
end

dap.adapters.coreclr = {
  type = 'executable',
  command = vim.fn.exepath('netcoredbg'),
  args = { '--interpreter=vscode' },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    cwd = '${fileDirname}',
    program = get_dll,
  },
}
