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
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("_highlight_yank"),
  callback = function()
    local on_yank = vim.hl and vim.hl.on_yank or vim.highlight.on_yank
    on_yank({ higroup = "Visual", timeout = 200 })
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
  command = "tabdo wincmd =",
})

vim.api.nvim_create_autocmd("User", {
  group = augroup("_alpha"),
  pattern = "AlphaReady",
  callback = function(ev)
    vim.opt.showtabline = 0
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = ev.buf,
      once = true,
      callback = function()
        vim.opt.showtabline = 2
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("_csvview"),
  pattern = "csv",
  command = "silent! CsvViewEnable",
})
