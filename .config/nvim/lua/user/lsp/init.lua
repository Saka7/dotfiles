local M = {}

local mason = require("user.lsp.mason")
require("user.lsp.handlers").setup()

if vim.fn.exists(":LspInfo") == 0 then
  vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd.checkhealth("vim.lsp")
  end, { desc = "Alias to :checkhealth vim.lsp" })
end

function M.start_all()
  local started = {}
  for _, server in ipairs(mason.servers) do
    server = vim.split(server, "@")[1]
    local ok = pcall(vim.lsp.enable, server)
    if ok then
      table.insert(started, server)
    end
  end
  if #started == 0 then
    print("No LSP servers started")
  else
    print("Started LSP servers: " .. table.concat(started, ", "))
  end
end

function M.stop_all()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    print("No active LSP clients")
    return
  end
  for _, client in pairs(clients) do
    pcall(function()
      client:stop()
    end)
  end
  print("Stopped all LSP clients")
end

return M
