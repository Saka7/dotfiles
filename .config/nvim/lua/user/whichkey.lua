local M = {}

M.opts = {
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
    },
  },
  triggers = { "<auto>", mode = "nxso" },
}

function M.setup(_, opts)
  local which_key = require("which-key")
  which_key.setup(opts)
  which_key.add(require("user.keymaps").groups)
end

return M
