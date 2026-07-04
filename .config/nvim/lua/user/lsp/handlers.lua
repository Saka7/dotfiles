local M = {}

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local function ensure_supports_method_compat(client)
	if not client or type(client) ~= "table" or rawget(client, "_supports_method_compat") then
		return
	end

	local native_supports_method = rawget(client, "supports_method")
	if type(native_supports_method) ~= "function" then
		return
	end

	client.supports_method = function(a, b, ...)
		if a == client then
			return native_supports_method(client, b, ...)
		end
		return native_supports_method(client, a, b, ...)
	end
	rawset(client, "_supports_method_compat", true)
end

local function wrap_client(client)
	if not client then
		return client
	end

	local proxy = setmetatable({}, {
		__index = client,
	})

	-- Keep illuminate compatible with both dot and colon call styles.
	proxy.supports_method = function(a, b, ...)
		local method = b
		if method == nil and type(a) == "string" then
			method = a
		end
		return client:supports_method(method, ...)
	end

	return proxy
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local config = {
		virtual_text = false,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "X",
				[vim.diagnostic.severity.WARN] = "x",
				[vim.diagnostic.severity.HINT] = "?",
				[vim.diagnostic.severity.INFO] = "!",
			},
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end
end

local function lsp_keymaps(bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
end

M.on_attach = function(client, bufnr)
	ensure_supports_method_compat(client)

	if client.name == "ts_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(wrap_client(client))
end

return M
