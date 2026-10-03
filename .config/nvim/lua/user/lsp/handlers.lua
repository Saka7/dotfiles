local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("blink.cmp").get_lsp_capabilities(M.capabilities)

M.setup = function()
  local config = {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "X",
        [vim.diagnostic.severity.WARN] = "x",
        [vim.diagnostic.severity.HINT] = "?",
        [vim.diagnostic.severity.INFO] = "!",
      },
    },
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      source = "always",
      header = "",
      prefix = "",
    },
    jump = {
      on_jump = function(diagnostic, bufnr)
        if diagnostic then
          vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
        end
      end,
    },
  }

  vim.diagnostic.config(config)

  -- Keep shared mappings independent of server-specific on_attach callbacks.
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client then
        M.on_attach(client, event.buf)
      end
    end,
  })
end

M.on_attach = function(client, bufnr)
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end

  require("user.keymaps").attach_lsp(bufnr)
end

return M
