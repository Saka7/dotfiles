local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		sql = { "sql_formatter" },
	},
	format_on_save = false,
	formatters = {
		sql_formatter = {
			prepend_args = { "--config", '{"keywordCase": "upper"}' },
		},
	},
})