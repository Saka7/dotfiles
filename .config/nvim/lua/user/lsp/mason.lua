local M = {}

M.servers = {
  lua_ls = "lua-language-server",
  cssls = "css-lsp",
  html = "html-lsp",
  ts_ls = "typescript-language-server",
  eslint = "eslint-lsp",
  pyright = "pyright",
  ruff = "ruff",
  bashls = "bash-language-server",
  jsonls = "json-lsp",
  yamlls = "yaml-language-server",
}

M.packages = {
  { "js-debug-adapter", version = "v1.140.0" },
  "prettier",
  "shfmt",
  "sql-formatter",
  "stylua",
}

local server_packages = vim.tbl_values(M.servers)
table.sort(server_packages)
vim.list_extend(M.packages, server_packages)

local settings = {
  ui = {
    border = "none",
  },
}

require("mason").setup(settings)
require("mason-tool-installer").setup({
  ensure_installed = M.packages,
  auto_update = false,
  run_on_start = true,
  start_delay = 3000,
  debounce_hours = 24,
  integrations = {
    ["mason-lspconfig"] = false,
    ["mason-null-ls"] = false,
    ["mason-nvim-dap"] = false,
  },
})

local handlers = require("user.lsp.handlers")

vim.lsp.config("*", {
  capabilities = handlers.capabilities,
})

for _, server in ipairs({ "eslint", "html", "jsonls", "lua_ls", "pyright" }) do
  vim.lsp.config(server, require("user.lsp." .. server))
end

vim.lsp.enable(vim.tbl_keys(M.servers))

return M
