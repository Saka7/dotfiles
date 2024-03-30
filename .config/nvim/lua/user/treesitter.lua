local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = { "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx", "css", "yaml", "markdown" },
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true },
})
