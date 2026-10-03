return {
  signs = {
    delete = { text = "_" },
    topdelete = { text = "‾" },
  },
  signs_staged = {
    delete = { text = "_" },
    topdelete = { text = "‾" },
    untracked = { text = "┆" },
  },
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  on_attach = function(bufnr)
    return vim.bo[bufnr].filetype ~= "bigfile"
  end,
  preview_config = {
    border = "single",
  },
}
