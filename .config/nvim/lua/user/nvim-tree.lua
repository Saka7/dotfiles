return {
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  renderer = {
    root_folder_modifier = ":t",
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  view = {
    width = 45,
  },
  filters = {
    dotfiles = true,
  },
}
