return {
  options = {
    close_command = "bdelete %d",
    right_mouse_command = "bdelete %d",
    indicator = { style = "icon", icon = "▎" },
    buffer_close_icon = "",
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    enforce_regular_tabs = true,
  },
}
