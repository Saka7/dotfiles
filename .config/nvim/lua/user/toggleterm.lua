local toggleterm = require("toggleterm")

toggleterm.setup({
	size = 20,
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function(event)
    require("user.whichkey").terminal_keymaps(event.buf)
  end,
})

local Terminal = require("toggleterm.terminal").Terminal

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
	node:toggle()
end
