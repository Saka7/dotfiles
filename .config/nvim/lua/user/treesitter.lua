local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "yaml",
    "dap_repl",
  },
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = false },
})

vim.treesitter.query.set(
  "markdown",
  "injections",
  [[
(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((inline) @injection.content
  (#set! injection.language "markdown_inline"))

((pipe_table_cell) @injection.content
  (#set! injection.language "markdown_inline"))
]]
)

vim.treesitter.query.set("markdown_inline", "injections", "")
