local M = {}

M.servers = {
	"lua_ls",
	"cssls",
	"html",
	"ts_ls",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
}

M.tools = {
	"eslint_d",
	"prettier",
	"ruff",
	"shfmt",
	"sql-formatter",
	"stylua",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = M.servers,
	automatic_enable = false,
})
require("mason-tool-installer").setup({
	ensure_installed = M.tools,
})

local handlers = require("user.lsp.handlers")

for _, server in pairs(M.servers) do
	local opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	vim.lsp.config[server] = opts
	vim.lsp.enable(server)
end

return M
