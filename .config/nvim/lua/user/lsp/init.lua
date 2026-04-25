local M = {}

require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.conform")

function M.start_all()
  local started = {}
  for server, _ in pairs(vim.lsp.config) do
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
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    print("No active LSP clients")
    return
  end
  for _, client in pairs(clients) do
    pcall(vim.lsp.stop_client, client.id)
  end
  print("Stopped all LSP clients")
end

return M
