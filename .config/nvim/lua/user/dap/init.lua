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

local node_skip_files = { '<node_internals>/**/*.js', 'node_modules/**/*.js' }
local ts_runtime_args = { '-r', 'ts-node/register', '--nolazy' }
local pick_process = require('dap.utils').pick_process

local function node_config(opts)
  return vim.tbl_extend("force", {
    type = "pwa-node",
    cwd = "${workspaceFolder}",
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = node_skip_files,
    smartStep = true,
  }, opts)
end

dap.configurations.javascript = {
  node_config({
    request = "launch",
    name = "Launch file",
    program = "${file}",
    sourceMaps = true,
  }),
  node_config({
    request = "attach",
    name = "Attach",
    processId = pick_process,
    sourceMaps = true,
  }),
}

dap.configurations.typescript = {
  node_config({
    request = "launch",
    name = "Launch file",
    program = "${file}",
    runtimeArgs = ts_runtime_args,
  }),
  node_config({
    request = "attach",
    name = "Attach",
    processId = pick_process,
    runtimeArgs = ts_runtime_args,
  }),
}
