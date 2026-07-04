local function color(name, attr, fallback)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok and hl and hl[attr] then
    return string.format("#%06x", hl[attr])
  end
  return fallback
end

local colors = {
  search = color("Search", "bg", "#ff9e64"),
  error = color("DiagnosticError", "fg", "#db4b4b"),
  warning = color("DiagnosticWarn", "fg", "#e0af68"),
  info = color("DiagnosticInfo", "fg", "#0db9d7"),
  hint = color("DiagnosticHint", "fg", "#10b981"),
  misc = color("Statement", "fg", "#bb9af7"),
}

require("scrollbar").setup({
  marks = {
    Search = { color = colors.search },
    Error = { color = colors.error },
    Warn = { color = colors.warning },
    Info = { color = colors.info },
    Hint = { color = colors.hint },
    Misc = { color = colors.misc },
  }
})

require("scrollbar.handlers.gitsigns").setup()
