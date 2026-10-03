local M = {}

local restore_failed = false

local function session_path()
  local name = vim.fn.getcwd(-1, -1):gsub("\n", "\r\n"):gsub('([/\\:*?"\'<>+ |%.%%])', function(char)
    return string.format("%%%02X", string.byte(char))
  end)
  return vim.fn.stdpath("data") .. "/sessions/" .. name .. ".vim"
end

local function report(action, err)
  vim.notify("Session " .. action .. " failed: " .. tostring(err), vim.log.levels.WARN)
end

local function clear_directory_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if vim.bo[buf].buftype == "" and not vim.bo[buf].modified and vim.fn.isdirectory(name) == 1 then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end

function M.restore()
  clear_directory_buffers()
  local path = session_path()
  if vim.fn.filereadable(path) == 0 then
    return
  end

  local ok, err = pcall(function()
    vim.cmd.source(vim.fn.fnameescape(path))
    clear_directory_buffers()
  end)
  restore_failed = not ok
  if not ok then
    report("restore", err)
  end
end

local function has_files()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if vim.bo[buf].buflisted and vim.bo[buf].buftype == "" and name ~= "" and vim.fn.isdirectory(name) == 0 then
      return true
    end
  end
  return false
end

local function close_special_windows()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) then
      local buf = vim.api.nvim_win_get_buf(win)
      local buftype = vim.bo[buf].buftype
      if buftype ~= "" and buftype ~= "help" then
        pcall(vim.api.nvim_win_close, win, true)
      end
    end
  end
end

function M.save()
  if restore_failed or vim.v.dying > 0 or (vim.v.exiting ~= vim.NIL and vim.v.exiting ~= 0) or not has_files() then
    return
  end

  local path = session_path()
  local temporary = path .. ".tmp"
  local previous_session = vim.v.this_session
  local ok, err = pcall(function()
    clear_directory_buffers()
    close_special_windows()
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    vim.cmd.mksession({ vim.fn.fnameescape(temporary), bang = true })
    assert(vim.uv.fs_rename(temporary, path))
    vim.v.this_session = path
  end)
  if not ok then
    vim.v.this_session = previous_session
    vim.fn.delete(temporary)
    report("save", err)
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("_native_session", { clear = true })
  local args = vim.fn.argv()
  local directory = #args == 1 and vim.fn.isdirectory(args[1]) == 1 and vim.fn.fnamemodify(args[1], ":p") or nil
  if (#args > 0 and not directory) or vim.tbl_contains(vim.v.argv, "-") then
    return
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    once = true,
    callback = function()
      if #vim.api.nvim_list_uis() == 0 or vim.v.this_session ~= "" then
        return
      end
      if directory then
        vim.cmd.cd(vim.fn.fnameescape(directory))
      end
      M.restore()
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        callback = M.save,
      })
    end,
  })
end

return M
