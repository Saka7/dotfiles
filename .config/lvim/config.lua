vim.keymap.set("i", "jj", "<Esc>")
vim.opt.timeoutlen = 300
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.colorcolumn = '120'

lvim.leader = "space"
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
-- lvim.colorscheme = "vscode"
-- lvim.colorscheme = "gruvbox-material"
lvim.colorscheme = "darcula"

lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.normal_mode["<C-S-c>"] = ":!xclip -sel c<CR>"
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprev<CR>"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = 'horizontal'

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 45;

lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "yaml",
}

lvim.builtin.telescope.defaults.layout_config = {
  width = 0.75,
  preview_cutoff = 120,
  horizontal = {
    prompt_position = "top",
    preview_width = function(_, cols, _)
      if cols < 120 then
        return math.floor(cols * 0.5)
      end
      return math.floor(cols * 0.6)
    end,
    mirror = false,
  },
  vertical = {
    mirror = true,
    prompt_position = "top",
    preview_cutoff = 0,
    preview_height = 0.65,
  }
}

lvim.builtin.which_key.vmappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle" },
  ["r"] = { ":'<,'>SnipRun<cr>", "Run snippet" },
  ["f"] = { require("lvim.lsp.utils").format, "Format" },
}

lvim.builtin.which_key.mappings = {
  [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>lua require('lvim.utils.functions').smart_quit()<CR>", "Quit" },
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle" },
  ["\\"] = { "<cmd>ToggleTerm<cr>", "Toggle terminal" },
  ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
  ["f"] = { require("lvim.core.telescope.custom-finders").find_project_files, "Find File" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["o"] = { "<cmd>SymbolsOutline<CR>", "Outline" },
  ["u"] = { "<cmd>UndotreeToggle<CR>", "UndoTree" },
  F = {
    name = "Folds",
    o = { "<cmd>lua require('ufo').openAllFolds()<cr>", "Open All" },
    c = { "<cmd>lua require('ufo').closeAllFolds()<cr>", "Close All" }
  },
  b = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { "<cmd>Telescope buffers<cr>", "Find" },
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
    e = {
      "<cmd>BufferLinePickClose<cr>",
      "Pick which buffer to close",
    },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = {
      "<cmd>BufferLineCloseRight<cr>",
      "Close all to the right",
    },
    D = {
      "<cmd>BufferLineSortByDirectory<cr>",
      "Sort by directory",
    },
    L = {
      "<cmd>BufferLineSortByExtension<cr>",
      "Sort by language",
    },
  },
  d = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
  },
  g = {
    name = "Git",
    g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    L = { "<cmd>G blame<cr>", "Toggle Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    f = { require("lvim.lsp.utils").format, "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    t = { "<cmd>Telescope live_grep_args<cr>", "Text with args" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  t = {
    name = "Tests",
    f = { ':TestFile -strategy=toggleterm<cr>', "file" },
    n = { ':TestNearest -strategy=toggleterm<cr>', "nearest" },
    s = { ':TestSuite -strategy=toggleterm<cr>', "suite" },
    l = { ':TestLast -strategy=toggleterm<cr>', "last" },
  },
  r = {
    name = "Spectre",
    c = { "<cmd>lua require(\"spectre\").open_visual({select_word=true})<CR>", 'Search current word'},
    f = { "<cmd>lua require(\"spectre\").open_visual({select_word=true})<CR>", 'Search current file'},
    r = { ":Spectre<cr>", "Open Spectre" },
  },
}

lvim.plugins = {
  { "doums/darcula" },
  { 'Mofiqul/vscode.nvim' },
  { 'sainnhe/gruvbox-material' },
  { 'jremmen/vim-ripgrep' },
  { 'vim-test/vim-test' },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "tpope/vim-fugitive" },
  { "mbbill/undotree" },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("scrollbar").setup({
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        }
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require('hlslens').setup()
      require("scrollbar.handlers.search").setup({})
    end,
  },
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require("symbols-outline").setup {
        position = 'left',
        autofold_depth = 1,
      }
    end
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    config = function()
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
    end
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup({})
    end
  },
  {
    'michaelb/sniprun', run = 'bash ./install.sh'
  },
  {
    'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        close_fold_kinds = {'imports', 'comment'},
        ufo_open_all_folds = 1,
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end
      })
    end
  },
  {
    "microsoft/vscode-js-debug",
    version = "1.x",
    build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
  },
  { "mxsdev/nvim-dap-vscode-js" }
}

lvim.builtin.dap.active = true

local home_dir = os.getenv("HOME")
local dap = require("dap")

require("dap-vscode-js").setup({
  debugger_path = home_dir .. "/.local/share/lunarvim/site/pack/packer/start/vscode-js-debug",
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})


dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**/*.js', 'node_modules/**/*.js' },
    smartStep = true,
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**/*.js', 'node_modules/**/*.js' },
    smartStep = true,
  }
}

dap.configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**/*.js', 'node_modules/**/*.js' },
    smartStep = true,
    runtimeArgs = {
        '-r', 'ts-node/register',
        '--nolazy',
    },
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**/*.js', 'node_modules/**/*.js' },
    smartStep = true,
    runtimeArgs = {
        '-r', 'ts-node/register',
        '--nolazy',
    },
  }
}

