vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapBreakpointRejected", { text = "⬤", texthl = "DiagnosticError" })

local M = {}

local dap_config = {
  log = {
    level = "info",
  },
  ui = {
    config = {
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
    },
  },
}

local dap = require("dap")
local dapui = require("dapui")
local js_debug_adapter = vim.fn.exepath("js-debug-adapter")

if js_debug_adapter == "" then
  error("js-debug-adapter is not installed; run :MasonToolsInstall")
end

dap.set_log_level(dap_config.log.level)
dapui.setup(dap_config.ui.config)

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = js_debug_adapter,
    args = { "${port}" },
  },
}

local node_skip_files = { "<node_internals>/**/*.js", "node_modules/**/*.js" }
local pick_process = require("dap.utils").pick_process

function M.project_root(path)
  path = path or vim.api.nvim_buf_get_name(0)
  if path == "" then
    return vim.fn.getcwd()
  end

  return vim.fs.root(path, { "package.json", ".git" }) or vim.fs.dirname(path)
end

local function resolve_workspace_folder(value, root)
  if type(value) == "string" then
    return value:gsub("%${workspaceFolder}", function()
      return root
    end)
  end
  if type(value) ~= "table" then
    return value
  end

  for key, item in pairs(value) do
    value[key] = resolve_workspace_folder(item, root)
  end
  return value
end

function M.launch_configurations(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local root = M.project_root(filename)
  local launch_json = vim.fs.joinpath(root, ".vscode", "launch.json")
  local configurations = require("dap.ext.vscode").getconfigs(launch_json)
  return vim.tbl_map(function(config)
    return resolve_workspace_folder(config, root)
  end, configurations)
end

dap.providers.configs["dap.launch.json"] = function(bufnr)
  return M.launch_configurations(bufnr)
end

local function node_config(opts)
  return vim.tbl_extend("force", {
    type = "pwa-node",
    cwd = function()
      return M.project_root()
    end,
    console = "integratedTerminal",
    skipFiles = node_skip_files,
    smartStep = true,
  }, opts)
end

dap.configurations.javascript = {
  node_config({
    request = "launch",
    name = "Launch current JavaScript file",
    program = "${file}",
    sourceMaps = true,
  }),
  node_config({
    request = "attach",
    name = "Attach to Node process",
    processId = pick_process,
    sourceMaps = true,
  }),
}

dap.configurations.typescript = {
  node_config({
    request = "attach",
    name = "Attach to TypeScript process",
    processId = pick_process,
  }),
}

dap.configurations.javascriptreact = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.typescript

return M
