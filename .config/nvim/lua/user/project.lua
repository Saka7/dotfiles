local project = require("project_nvim")
local telescope = require("telescope")

project.setup({
    active = true,
    on_config_done = nil,
    manual_mode = false,
    detection_methods = { "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    show_hidden = false,
    silent_chdir = true,
    ignore_lsp = {},
    datapath = vim.fn.stdpath("data"),
})

telescope.load_extension('projects')

