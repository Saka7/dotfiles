local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  { 'Mofiqul/vscode.nvim', priority = 1000 },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("user.autopairs")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.bufferline")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.lualine")
    end,
  },

  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    event = "VimEnter",
    config = function()
      require("user.alpha")
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("user.whichkey").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("user.indentline")
    end,
  },

  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("user.neoscroll")
    end,
  },

  {
    'petertriho/nvim-scrollbar',
    event = "VeryLazy",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kevinhwang91/nvim-hlslens",
    },
    config = function()
      require("user.scrollbar")
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require("user.hlslens")
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.todo-comments")
    end,
  },

  { "mbbill/undotree", cmd = "UndotreeToggle" },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.nvim-tree")
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    config = function()
      require("user.toggleterm")
    end,
  },

  {
    "hedyhli/outline.nvim",
    cmd = "Outline",
    config = function()
      require("user.symbols-outline")
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("user.ufo")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("user.vcs.gitsigns")
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git", "GBrowse" },
    dependencies = { "tpope/vim-rhubarb" },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.vcs.diffview")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("user.treesitter")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("user.lsp")
    end,
  },

  { "williamboman/mason.nvim", lazy = true },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("user.lsp.conform")
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("user.lsp.lint")
    end,
  },

  {
    "Wansmer/treesj",
    lazy = true,
    config = function()
      require("user.treesj")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      require("user.cmp")
    end,
  },

  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      require("user.autosession")
    end,
  },

  {
    "nvim-neotest/neotest",
    lazy = true,
    cmd = "Neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("user.neotest")
    end,
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
  },

  { "nvim-telescope/telescope-live-grep-args.nvim", lazy = true },
  { "mustache/vim-mustache-handlebars", ft = { "html.handlebars", "html.mustache" } },

  {
    "microsoft/vscode-js-debug",
    version = "1.x",
    build = "npm i && npm run compile dapDebugServer",
    lazy = true,
  },

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = "DapClearBreakpoints",
    dependencies = {
      "microsoft/vscode-js-debug",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("user.dap")
    end,
  },

  { "rcarriga/nvim-dap-ui", lazy = true, dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
  { 'theHamsta/nvim-dap-virtual-text', lazy = true, cmd = "DapVirtualTextToggle" },

  { "hat0uma/csvview.nvim", ft = "csv", cmd = "CsvViewEnable" },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = {
        enabled = true,
        size = 5 * 1024 * 1024,
      },
      words = {
        enabled = true,
      },
    },
  }
}

require("lazy").setup(plugins, {
  rocks = {
    enabled = false,
  },
})
