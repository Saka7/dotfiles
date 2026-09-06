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
		["html.handlebars"] = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
		python = { "ruff_format" },
		lua = { "stylua" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		sql = { "sql_formatter" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = false,
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
	notify_no_formatters = true,
	formatters = {
		prettier = {
			append_args = function(_, ctx)
				if vim.bo[ctx.buf].filetype ~= "markdown" then
					return {}
				end

				local print_width = tonumber(vim.o.colorcolumn:match("%d+")) or 120
				return { "--print-width", tostring(print_width), "--prose-wrap", "always" }
			end,
		},
		sql_formatter = {
			prepend_args = { "--config", '{"keywordCase": "upper"}' },
		},
	},
})
