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

local function context_path(name, options)
  local absolute_path = vim.fs.normalize(vim.fn.fnamemodify(name, ":p"))
  if path_style(options) == "absolute" then
    return absolute_path
  end

  return vim.fs.normalize(vim.fn.fnamemodify(absolute_path, ":."))
end

local function current_file(options)
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return nil
  end

  return context_path(name, options)
end

local function copy(text, description)
  local ok, err = pcall(vim.fn.setreg, "+", text)
  if not ok then
    notify("Could not copy to clipboard: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  notify(description .. " copied to clipboard", vim.log.levels.INFO)
end

local function copy_buffer_paths(bufnrs, empty_message, options)
  local paths = {}
  local seen = {}

  for _, bufnr in ipairs(bufnrs) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name ~= "" and vim.bo[bufnr].buftype == "" then
        local path = context_path(name, options)
        if not seen[path] then
          seen[path] = true
          table.insert(paths, path)
        end
      end
    end
  end

  if #paths == 0 then
    notify(empty_message, vim.log.levels.WARN)
    return
  end

  copy(table.concat(paths, "\n"), "Buffer context")
end

function M.setup(options)
  options = options or {}
  if options.path_style ~= nil then
    path_style(options)
  end

  config = vim.tbl_extend("force", config, options)
end

function M.copy_selection(options)
  local file = current_file(options)
  if not file then
    notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end

  local mode = vim.fn.mode()
  local in_visual_mode = mode == "v" or mode == "V" or mode == "\22"
  local first_line = vim.fn.line(in_visual_mode and "v" or "'<")
  local last_line = vim.fn.line(in_visual_mode and "." or "'>")
  if first_line == 0 or last_line == 0 then
    notify("No visual selection found", vim.log.levels.WARN)
    return
  end

  if first_line > last_line then
    first_line, last_line = last_line, first_line
  end

  local line_reference = first_line == last_line
      and tostring(first_line)
      or string.format("%d-%d", first_line, last_line)

  copy(string.format("%s:%s", file, line_reference), "Selection context")
end

function M.copy_file(options)
  local file = current_file(options)
  if not file then
    notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end

  copy(file, "File context")
end

function M.copy_buffers(options)
  local bufnrs = {}

  for _, buffer in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    table.insert(bufnrs, buffer.bufnr)
  end

  copy_buffer_paths(bufnrs, "No open file buffers found", options)
end

function M.select_buffers(options)
  local telescope_ok, telescope = pcall(require, "telescope.builtin")
  if not telescope_ok then
    local lazy_ok, lazy = pcall(require, "lazy")
    if lazy_ok then
      lazy.load({ plugins = { "telescope.nvim" } })
      telescope_ok, telescope = pcall(require, "telescope.builtin")
    end
  end

  if not telescope_ok then
    notify("Telescope is unavailable", vim.log.levels.ERROR)
    return
  end

  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  telescope.buffers({
    prompt_title = "Select Buffers to Copy",
    show_all_buffers = true,
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local picker = action_state.get_current_picker(prompt_bufnr)
        local entries = picker:get_multi_selection()

        if #entries == 0 then
          local entry = action_state.get_selected_entry()
          if entry then
            entries = { entry }
          end
        end

        actions.close(prompt_bufnr)

        local bufnrs = {}
        for _, entry in ipairs(entries) do
          if entry.bufnr then
            table.insert(bufnrs, entry.bufnr)
          end
        end

        copy_buffer_paths(bufnrs, "No file buffers selected", options)
      end)

      return true
    end,
  })
end

return M
