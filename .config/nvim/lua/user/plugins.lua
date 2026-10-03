local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 or not vim.uv.fs_stat(lazypath) then
    error("Could not install lazy.nvim:\n" .. output)
  end
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Core runtime and shared dependencies
  { "Mofiqul/vscode.nvim", priority = 1000 },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      zen = {
        win = {
          backdrop = { transparent = false, blend = 0 },
        },
      },
      bigfile = {
        enabled = true,
        size = require("user.bigfile").size,
        line_length = require("user.bigfile").line_length,
        setup = require("user.bigfile").setup,
      },
      indent = require("user.indent"),
      words = {
        enabled = true,
      },
    },
    keys = require("user.keymaps").plugins.snacks,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("user.treesitter")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = require("user.whichkey").opts,
    config = require("user.whichkey").setup,
  },

  -- Editing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("user.autopairs")
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = require("user.blink"),
  },
  {
    "Wansmer/treesj",
    opts = { use_default_keymaps = false },
    keys = require("user.keymaps").plugins.treesj,
  },
  { "karb94/neoscroll.nvim", event = "VeryLazy", opts = {} },

  -- Interface and navigation
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = require("user.bufferline"),
    keys = require("user.keymaps").plugins.bufferline,
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    opts = {
      calm_down = true,
      nearest_only = true,
      nearest_float_when = "auto",
    },
    keys = require("user.keymaps").plugins.hlslens,
  },
  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      require("user.scrollview").setup()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = require("user.keymaps").plugins.nvim_tree,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("user_nvim_tree_startup", { clear = true }),
        once = true,
        callback = function(event)
          if vim.v.this_session ~= "" then
            return
          end

          local directory = vim.fn.fnamemodify(event.file, ":p")
          if vim.fn.isdirectory(directory) == 0 then
            return
          end

          require("lazy").load({ plugins = { "nvim-tree.lua" } })
          require("nvim-tree.api").tree.open({ path = directory })
        end,
      })
    end,
    opts = require("user.nvim-tree"),
  },
  {
    "hedyhli/outline.nvim",
    cmd = "Outline",
    opts = { outline_window = { position = "left" } },
    keys = require("user.keymaps").plugins.outline,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jmacadie/telescope-hierarchy.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("user.telescope")
    end,
    keys = require("user.keymaps").plugins.telescope,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = require("user.vcs.gitsigns"),
    keys = require("user.keymaps").plugins.gitsigns,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = require("user.vcs.diffview"),
    keys = require("user.keymaps").plugins.diffview,
  },

  -- Language tooling
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("user.lsp")
    end,
  },
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    opts = require("user.lsp.conform"),
    keys = require("user.keymaps").plugins.conform,
  },
  { "mustache/vim-mustache-handlebars", ft = { "html.handlebars", "html.mustache" } },

  -- Tests and debugging
  {
    "nvim-neotest/neotest",
    cmd = "Neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("user.neotest")
    end,
    keys = require("user.keymaps").plugins.neotest,
  },
  {
    "mfussenegger/nvim-dap",
    cmd = "DapClearBreakpoints",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
    },
    config = function()
      require("user.dap")
    end,
    keys = require("user.keymaps").plugins.dap,
  },

  { "hat0uma/csvview.nvim", ft = "csv", cmd = "CsvViewEnable" },
}

require("lazy").setup(plugins, {
  rocks = {
    enabled = false,
  },
})
