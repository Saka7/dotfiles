local M = {}

local config = {
  path_style = "relative",
}

local function notify(message, level)
  vim.notify(message, level, { title = "Agent Context" })
end

local function path_style(options)
  local style = config.path_style
  if options and options.path_style ~= nil then
    style = options.path_style
  end

  if style ~= "relative" and style ~= "absolute" then
    error('Agent Context path_style must be "relative" or "absolute"')
  end

  return style
end

local function buffer_path(bufnr, style)
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
    return nil
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return nil
  end

  local absolute_path = vim.fs.normalize(vim.fn.fnamemodify(name, ":p"))
  if style == "absolute" then
    return absolute_path
  end

  return vim.fs.normalize(vim.fn.fnamemodify(absolute_path, ":."))
end

local function copy(text, description)
  local ok, result = pcall(vim.fn.setreg, "+", text)
  if not ok or result ~= 0 then
    notify("Could not copy to clipboard: " .. tostring(result), vim.log.levels.ERROR)
    return false
  end

  notify(description .. " copied to clipboard", vim.log.levels.INFO)
  return true
end

local function collect_buffer_paths(bufnrs, style)
  local paths = {}
  local seen = {}

  for _, bufnr in ipairs(bufnrs) do
    local path = buffer_path(bufnr, style)
    if path and not seen[path] then
      seen[path] = true
      table.insert(paths, path)
    end
  end

  return paths
end

local function copy_buffer_paths(bufnrs, empty_message, style)
  local paths = collect_buffer_paths(bufnrs, style)
  if #paths == 0 then
    notify(empty_message, vim.log.levels.WARN)
    return
  end

  copy(table.concat(paths, "\n"), "Buffer context")
end

local function selection_range()
  local mode = vim.fn.mode()
  local in_visual_mode = mode == "v" or mode == "V" or mode == "\22"
  local first_line = vim.fn.line(in_visual_mode and "v" or "'<")
  local last_line = vim.fn.line(in_visual_mode and "." or "'>")
  if first_line == 0 or last_line == 0 then
    return nil
  end

  return math.min(first_line, last_line), math.max(first_line, last_line)
end

local function accept_buffer_selection(prompt_bufnr, style)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local entries = picker:get_multi_selection()

  if #entries == 0 then
    local entry = action_state.get_selected_entry()
    if entry then
      entries = { entry }
    end
  end

  local bufnrs = {}
  for _, entry in ipairs(entries) do
    if entry.bufnr then
      table.insert(bufnrs, entry.bufnr)
    end
  end

  actions.close(prompt_bufnr)
  copy_buffer_paths(bufnrs, "No file buffers selected", style)
end

function M.setup(options)
  options = options or {}
  if options.path_style ~= nil then
    path_style(options)
  end

  config = vim.tbl_extend("force", config, options)
end

function M.copy_selection(options)
  local file = buffer_path(vim.api.nvim_get_current_buf(), path_style(options))
  if not file then
    notify("Current buffer is not a named file buffer", vim.log.levels.WARN)
    return
  end

  local first_line, last_line = selection_range()
  if not first_line then
    notify("No visual selection found", vim.log.levels.WARN)
    return
  end

  local line_reference = first_line == last_line and tostring(first_line)
    or string.format("%d-%d", first_line, last_line)

  copy(string.format("%s:%s", file, line_reference), "Selection context")
end

function M.copy_file(options)
  local file = buffer_path(vim.api.nvim_get_current_buf(), path_style(options))
  if not file then
    notify("Current buffer is not a named file buffer", vim.log.levels.WARN)
    return
  end

  copy(file, "File context")
end

function M.copy_buffers(options)
  local style = path_style(options)
  local bufnrs = {}

  for _, buffer in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    table.insert(bufnrs, buffer.bufnr)
  end

  copy_buffer_paths(bufnrs, "No open file buffers found", style)
end

function M.select_buffers(options)
  local style = path_style(options)
  local telescope_ok, telescope = pcall(require, "telescope.builtin")
  if not telescope_ok then
    notify("Telescope is unavailable", vim.log.levels.ERROR)
    return
  end

  local actions = require("telescope.actions")

  telescope.buffers({
    show_all_buffers = true,
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        accept_buffer_selection(prompt_bufnr, style)
      end)

      return true
    end,
  })
end

return M
