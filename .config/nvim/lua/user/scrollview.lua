local M = {}

local max_lines = 50000
local excluded_filetypes = { "bigfile", "blink-cmp-menu", "prompt", "TelescopePrompt", "NvimTree", "Outline" }
local marker_symbols = { "-", "=" }

local function highlights()
  vim.api.nvim_set_hl(0, "ScrollView", { link = "CursorColumn" })
  vim.api.nvim_set_hl(0, "ScrollViewCursor", { link = "Normal" })
  local search = vim.api.nvim_get_hl(0, { name = "Search", link = false })
  vim.api.nvim_set_hl(0, "ScrollViewSearch", { fg = search.bg or search.fg })
end

local function update_visibility()
  local excluded = excluded_filetypes
  if vim.bo.buftype == "nofile" or vim.bo.buftype == "prompt" or vim.api.nvim_buf_line_count(0) > max_lines then
    excluded = vim.list_extend({ vim.bo.filetype }, excluded_filetypes)
  end
  if not vim.deep_equal(vim.g.scrollview_excluded_filetypes, excluded) then
    vim.g.scrollview_excluded_filetypes = excluded
    require("scrollview").refresh()
  end
end

function M.setup()
  require("scrollview").setup({
    current_only = true,
    excluded_filetypes = excluded_filetypes,
    byte_limit = require("user.bigfile").size,
    line_limit = max_lines,
    signs_on_startup = { "cursor", "search", "diagnostics" },
    cursor_symbol = "•",
    search_symbol = marker_symbols,
    diagnostics_error_symbol = marker_symbols,
    diagnostics_warn_symbol = marker_symbols,
    diagnostics_info_symbol = marker_symbols,
    diagnostics_hint_symbol = marker_symbols,
    winblend = 30,
    winblend_gui = 30,
  })
  require("scrollview.contrib.gitsigns").setup({
    hide_full_add = false,
    add_symbol = "┆",
    change_symbol = "┆",
    delete_symbol = "▁",
  })

  local group = vim.api.nvim_create_augroup("_scrollview", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = highlights })
  vim.api.nvim_create_autocmd(
    { "BufEnter", "FileType", "TextChanged", "TextChangedI" },
    { group = group, callback = update_visibility }
  )
  highlights()
  update_visibility()
end

return M
