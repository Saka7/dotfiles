local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
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
  { 'Mofiqul/vscode.nvim' },
  { 'folke/tokyonight.nvim' },
  { "kyazdani42/nvim-web-devicons" },
  { "echasnovski/mini.nvim" },

  { "nvim-lua/plenary.nvim" },
  { "windwp/nvim-autopairs" },
  { "akinsho/bufferline.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "ahmedkhalf/project.nvim"},
  { "lewis6991/impatient.nvim" },
  { "goolord/alpha-nvim" },
  { "folke/which-key.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "karb94/neoscroll.nvim" },
  { 'petertriho/nvim-scrollbar' },
  { "kevinhwang91/nvim-hlslens" },
  { "numToStr/Comment.nvim", },
  { "folke/todo-comments.nvim", },
  { "mbbill/undotree" },
  { "kyazdani42/nvim-tree.lua" },
  { "akinsho/toggleterm.nvim" },
  { "jremmen/vim-ripgrep" },
  { "simrat39/symbols-outline.nvim" },
  { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
  { "lewis6991/gitsigns.nvim" },
  { "tpope/vim-fugitive" },
  { "sindrets/diffview.nvim" },

  { "nvim-treesitter/nvim-treesitter" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "RRethy/vim-illuminate" },
  { "Wansmer/treesj" } ,

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "L3MON4D3/LuaSnip" },
    }
  },

  {
    'rmagatti/auto-session',
    lazy = false,
  },

  {
    "nvim-neotest/neotest",
    lazy = true,
    cmd = "Neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    }
  },

  { "nvim-telescope/telescope.nvim" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },

  {
    "microsoft/vscode-js-debug",
    version = "1.x",
    build = "npm i && npm run compile dapDebugServer",
  },
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'LiadOz/nvim-dap-repl-highlights' },
}

require("lazy").setup(plugins)

