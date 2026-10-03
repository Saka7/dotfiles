local telescope = require("telescope")

local default_config = {
  prompt_title = false,
  results_title = false,
  preview_title = false,
  fix_preview_title = true,
  layout_config = { preview_width = 0.7 },
}

local config = {
  defaults = {
    layout_strategy = "bottom_pane",
    layout_config = {
      width = 0.8,
      height = 0.99,
      prompt_position = "bottom",
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    mappings = require("user.keymaps").telescope(),
  },
  pickers = {
    find_files = vim.tbl_extend("force", default_config, {
      hidden = true,
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    }),
    live_grep = vim.tbl_extend("force", default_config, {
      only_sort_text = true,
      path_display = { "tail" },
      show_line = false,
      disable_devicons = true,
    }),
    grep_string = vim.tbl_extend("force", default_config, {
      only_sort_text = true,
      path_display = { "tail" },
      show_line = false,
      disable_devicons = true,
    }),
    buffers = vim.tbl_extend("force", default_config, {
      initial_mode = "normal",
    }),
    git_files = vim.tbl_extend("force", default_config, {
      show_untracked = true,
    }),
    git_status = vim.tbl_extend("force", default_config, {}),
  },
  extensions = {
    hierarchy = vim.tbl_extend("force", default_config, {
      initial_multi_expand = true,
      multi_depth = 8,
      layout_strategy = "vertical",
    }),
    live_grep_args = vim.tbl_extend("force", default_config, {}),
  },
}

telescope.setup(config)

telescope.load_extension("fzf")
telescope.load_extension("hierarchy")
telescope.load_extension("live_grep_args")
