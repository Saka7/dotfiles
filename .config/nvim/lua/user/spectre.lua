require('spectre').setup {
  open_cmd = 'new',
  mapping = {
    ['run_current_replace'] = {
      map = "<leader>r",
      cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
      desc = "replace current line"
    }
  }
}
