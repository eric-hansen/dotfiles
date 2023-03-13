return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function ()
      require('telescope').load_extension('dap')

      local dap = require('dap')
      dap.adapters.php = {
        type = 'executable',
        command = '/Users/ehansen/.nvm/versions/node/v12.22.12/bin/node',
        args = { '/Users/ehansen/Projects/vscode-php-debug/out/phpDebug.js' }
      }
      dap.configurations.php = {{
        type = 'php',
        request = 'launch',
        name = 'XDebug',
        port = 9000
      }}

      local dapui = require('dapui')
      dapui.setup {
        layouts = {
          {
            elements = {
              "breakpoints", "stacks", "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {"scopes"},
            size = 0.25,
            position = "bottom",
          },
        },
        controls = { enabled = false },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local conditional = function () require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end

vim.keymap.set('n', '<leader>ds', dap.continue, { desc = "Start/continue debugger" })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Start/continue debugger" })
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set('n', '<leader>dbc', conditional, { desc = "Debugger conditional breakpoint" })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = "Debugger step over" })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Debugger step into" })

      vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
      vim.fn.sign_define("DapStopped", { text = require('config').icons.arrows.right, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" })
    end,
  },
}
