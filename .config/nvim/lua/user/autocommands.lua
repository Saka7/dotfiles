local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.filetype.add({
  extension = {
    handlebars = "html.handlebars",
    hbs = "html.handlebars",
    mustache = "html.handlebars",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("_general_settings"),
  pattern = { "qf", "help", "man", "lspinfo" },
  callback = function(ev)
    require("user.keymaps").attach_special_buffer(ev.buf)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("_highlight_yank"),
  callback = function()
    local highlight_operation = vim.hl.hl_op or vim.hl.on_yank
    highlight_operation({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("_format_options"),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("_quickfix_settings"),
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("_git"),
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("_auto_resize"),
  callback = function()
    local current_tab = vim.api.nvim_get_current_tabpage()
    vim.cmd("tabdo wincmd =")
    vim.api.nvim_set_current_tabpage(current_tab)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("_csvview"),
  pattern = "csv",
  command = "CsvViewEnable",
})
