require("diffview").setup({
  diff_binaries    = false,
  enhanced_diff_hl = true,
  git_cmd          = { "git" },
  hg_cmd           = { "hg" },
  use_icons        = true,
  show_help_hints  = true,
  watch_index      = true,
  view = {
    merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
        winbar_info = true,
      },
  },

  hooks = {
    view_opened = function()
      require("diffview.actions").toggle_files()
    end,
  },
})
