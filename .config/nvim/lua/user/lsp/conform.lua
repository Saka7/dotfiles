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
		lua = { "stylua" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		sql = { "sql_formatter" },
	},
	format_on_save = false,
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
