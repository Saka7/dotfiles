local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	os.date("%A %d-%m %H:%M")
}
dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", "  MRU", ":Telescope oldfiles <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("f", "F  Find file", ":Telescope find_files <CR>"),
	dashboard.button("t", "T  Find text", ":Telescope live_grep <CR>"),
}

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
require("alpha").setup(dashboard.opts)
