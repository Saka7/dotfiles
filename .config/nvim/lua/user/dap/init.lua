local home_dir = os.getenv("HOME")

vim.fn.sign_define('DapBreakpoint', {text='⬤', texthl='DiagnosticSignError', linehl='', numhl=''})

local dap_config = {
  breakpoint = {
    text = '',
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  breakpoint_rejected = {
    text = '',
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = '󰁗',
    texthl = "DiagnosticSignWarn",
    linehl = "Visual",
    numhl = "DiagnosticSignWarn",
  },
  log = {
    level = "info",
  },
  ui = {
    auto_open = false,
    notify = {
      threshold = vim.log.levels.INFO,
    },
    config = {
      icons = { expanded = "", collapsed = "", circular = "" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      element_mappings = {},
      expand_lines = true,
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
      controls = {
        enabled = true,
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
        max_value_lines = 100,
      },
    },
  },
}

local dap = require("dap")
local dapui = require("dapui")

dap.set_log_level(dap_config.log.level)
dapui.setup(dap_config.ui.config)

if dap_config.ui.auto_open then
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
end

require("dap-vscode-js").setup({
  debugger_path = home_dir .. "/.npm/vscode-js-debug",
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

require("nvim-dap-virtual-text").setup({
  enabled = false
})

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
    processId = require'dap.utils'.pick_process,
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
    processId = require'dap.utils'.pick_process,
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

