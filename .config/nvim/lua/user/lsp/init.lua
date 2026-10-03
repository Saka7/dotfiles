local M = {}

local mason = require("user.lsp.mason")
require("user.lsp.handlers").setup()

if vim.fn.exists(":LspInfo") == 0 then
  vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd.checkhealth("vim.lsp")
  end, { desc = "Alias to :checkhealth vim.lsp" })
end

local function set_enabled(enabled)
  local servers = vim.tbl_keys(mason.servers)
  vim.lsp.enable(servers, enabled)
  table.sort(servers)

  local action = enabled and "Enabled" or "Disabled"
  vim.notify(action .. " automatic LSP activation for: " .. table.concat(servers, ", "))
end

function M.enable_all()
  set_enabled(true)
end

function M.disable_all()
  set_enabled(false)
end

require("user.keymaps").setup_lsp()

return M
