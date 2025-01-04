vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = 'DiagnosticInfo' })
vim.fn.sign_define('DapBreakpointRejected', { text = '⬤', texthl = 'DiagnosticError' })

local dap_config = {
  log = {
    level = "info",
  },
  ui = {
    notify = {
      threshold = vim.log.levels.INFO,
    },
    config = {
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl",    size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
    },
  },
}

local dap = require("dap")
local dapui = require("dapui")

dap.set_log_level(dap_config.log.level)
dapui.setup(dap_config.ui.config)

require("nvim-dap-virtual-text").setup({
  enabled = false
})

require('nvim-dap-repl-highlights').setup()

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/dist/src/dapDebugServer.js",
      "${port}"
    },
  }
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**/*.js', 'node_modules/**/*.js' },
    smartStep = true,
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require('dap.utils').pick_process,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**/*.js', 'node_modules/**/*.js' },
    smartStep = true,
  }
}

dap.configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**/*.js', 'node_modules/**/*.js' },
    smartStep = true,
    runtimeArgs = {
      '-r', 'ts-node/register',
      '--nolazy',
    },
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require('dap.utils').pick_process,
    cwd = "${workspaceFolder}",
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**/*.js', 'node_modules/**/*.js' },
    smartStep = true,
    runtimeArgs = {
      '-r', 'ts-node/register',
      '--nolazy',
    },
  }
}

