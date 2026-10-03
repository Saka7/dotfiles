return {
  enhanced_diff_hl = true,
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
}
