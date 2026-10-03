local M = {}
local diagnostic_counts = {}
local modes = {
  n = { "NORMAL", "Normal" },
  no = { "O-PENDING", "Normal" },
  v = { "VISUAL", "Visual" },
  V = { "V-LINE", "Visual" },
  ["\22"] = { "V-BLOCK", "Visual" },
  s = { "SELECT", "Visual" },
  S = { "S-LINE", "Visual" },
  ["\19"] = { "S-BLOCK", "Visual" },
  i = { "INSERT", "Insert" },
  R = { "REPLACE", "Replace" },
  Rv = { "V-REPLACE", "Replace" },
  c = { "COMMAND", "Command" },
  r = { "PROMPT", "Command" },
  ["!"] = { "SHELL", "Command" },
  t = { "TERMINAL", "Terminal" },
}

local function highlights()
  package.loaded["lualine.themes.vscode"] = nil
  local palette = require("lualine.themes.vscode")
  local function set(name, color)
    vim.api.nvim_set_hl(0, "UserStatusline" .. name, { fg = color.fg, bg = color.bg, bold = color.gui == "bold" })
  end
  set("Base", palette.normal.c)
  set("Inactive", palette.inactive.c)
  for _, name in ipairs({ "Normal", "Insert", "Visual", "Replace", "Command", "Terminal" }) do
    local section = palette[name:lower()]
    set(name .. "Accent", section.a)
    set(name .. "Mode", section.b)
  end
end

local function escape(text)
  return (tostring(text):gsub("%%", "%%%%"):gsub("%c", " "))
end

local function join(...)
  local parts = {}
  for _, part in ipairs({ ... }) do
    if part ~= "" then
      parts[#parts + 1] = part
    end
  end
  return table.concat(parts, "  ")
end

local function count(symbol, value)
  return (value or 0) > 0 and (symbol .. value) or ""
end

local function section(name, text)
  return "%#UserStatusline" .. name .. "# " .. text .. " "
end

local function git_branch(buf)
  local git = vim.b[buf].gitsigns_status_dict or {}
  local branch = git.head or vim.b[buf].gitsigns_head
  return branch and branch ~= "" and (" " .. escape(branch)) or ""
end

local function git_diff(buf, win)
  if vim.api.nvim_win_get_width(win) <= 80 then
    return ""
  end
  local git = vim.b[buf].gitsigns_status_dict or {}
  return join(count(" ", git.added), count(" ", git.changed), count(" ", git.removed))
end

local function diagnostics(buf, current_mode)
  if current_mode:sub(1, 1) ~= "i" or not diagnostic_counts[buf] then
    diagnostic_counts[buf] = vim.diagnostic.count(buf)
  end
  local counts = diagnostic_counts[buf]
  return join(count(" ", counts[vim.diagnostic.severity.ERROR]), count(" ", counts[vim.diagnostic.severity.WARN]))
end

local function mode(current_mode)
  local info = modes[current_mode] or modes[current_mode:sub(1, 2)] or modes[current_mode:sub(1, 1)] or modes.n
  return section(info[2] .. "Mode", "-- " .. info[1] .. " --") .. "%#UserStatuslineBase#", info[2]
end

local function file_details(buf)
  local bo = vim.bo[buf]
  return join(
    "spaces: " .. (bo.shiftwidth == 0 and bo.tabstop or bo.shiftwidth),
    escape(bo.fileencoding ~= "" and bo.fileencoding or vim.o.encoding),
    escape(bo.filetype)
  )
end

local function location(theme)
  return section(theme .. "Mode", "%l:%c")
end

function M.render()
  local win = vim.g.statusline_winid or vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)
  local filetype = vim.bo[buf].filetype
  if filetype == "NvimTree" or filetype == "Outline" then
    return "%#StatusLineNC#%="
  elseif win ~= vim.api.nvim_get_current_win() then
    return "%#UserStatuslineInactive# %f %m%r%=%l:%c "
  end

  local current_mode = vim.fn.mode(1)
  local mode_text, theme = mode(current_mode)
  local left = join(git_branch(buf), diagnostics(buf, current_mode))
  local accent = left ~= "" and section(theme .. "Accent", left) or ""
  local right = join(git_diff(buf, win), file_details(buf))
  return accent .. mode_text .. "%<%=" .. right .. " " .. location(theme)
end

function M.setup()
  highlights()
  vim.opt.laststatus = 2
  vim.opt.statusline = "%!v:lua.require'user.statusline'.render()"

  local group = vim.api.nvim_create_augroup("UserStatusline", { clear = true })
  -- Let window changes finish before drawing the statusline.
  local redraw = vim.schedule_wrap(function()
    vim.cmd.redrawstatus()
  end)
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = highlights,
  })
  vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged", "InsertLeave", "BufEnter", "WinEnter" }, {
    group = group,
    callback = redraw,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "GitSignsUpdate",
    callback = redraw,
  })
  vim.api.nvim_create_autocmd("BufWipeout", {
    group = group,
    callback = function(event)
      diagnostic_counts[event.buf] = nil
    end,
  })
end

return M
