local which_key = require("which-key")

local config = {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  keys = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },

  show_help = true,
  show_keys = true,
  triggers = { "<auto>", mode="nxso" }
}

local mappings = {
  {
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,

    { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment toggle" },

    { "<leader>;", "<cmd>Alpha<cr>" },

    { "<leader>F", group = "Folds" },
    { "<leader>Fc", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close All" },
    { "<leader>Fo", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open All" },

    { "<leader>P", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },

    { "<leader>\\", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },

    { "<leader>b", group = "Buffers" },
    { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
    { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
    { "<leader>be", "<cmd>BufferLinePickClose<cr>", desc = "Pick which buffer to close" },
    { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find" },
    { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
    { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Jump" },
    { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right" },
    { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next" },
    { "<leader>c", "<cmd>bdelete<cr>", desc = "Close Buffer" },

    { "<leader>d", group = "Debug" },
    { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
    { "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI" },
    { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
    { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
    { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
    { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
    { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
    { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
    { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },

    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },

    {
      "<leader>f",
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      desc = "Find files"
    },

    { "<leader>g", group = "Git" },
    { "<leader>gC", "<cmd>Telescope git_bcommits<cr>" },
    { "<leader>gL", "<cmd>G blame<cr>", desc = "Toggle Blame" },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = "Next Hunk" },
    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk" },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
    { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },

    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },

    { "<leader>l", group = "LSP"  },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", desc = "Format" },
    { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics" },
    { "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>", desc = "Format" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lt", "<cmd>lua require('treesj').toggle()<cr>", desc = "Split/Join" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", desc = "Next" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc = "Prev" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Set loc list" },
    { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },

    { "<leader>o", "<cmd>SymbolsOutline<cr>", desc = "Outline" },

    { "<leader>r", group = "Spectre" },
    { "<leader>rc", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word" },
    { "<leader>rf", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current file" },
    { "<leader>rr", ":Spectre<cr>", desc = "Open Spectre" },

    { "<leader>s", group = "Search" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Text" },
    { "<leader>sT", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = "Text with args" },
    { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },

    { "<leader>t", group = "Tests" },
    { "<leader>tL", '<cmd>Neotest run last strategy="dap"<cr>', desc = "Debug last" },
    { "<leader>tO", "<cmd>Neotest output<cr>", desc = "Output" },
    { "<leader>ta", "<cmd>Neotest attach<cr>", desc = "Attach to nearest" },
    { "<leader>td", '<cmd>Neotest run strategy="dap"<cr>', desc = "Debug nearest" },
    { "<leader>tf", "<cmd>Neotest run file<cr>", desc = "Run file" },
    { "<leader>tl", "<cmd>Neotest run last<cr>", desc = "Run last" },
    { "<leader>tn", "<cmd>Neotest run<cr>", desc = "Run nearest" },
    { "<leader>to", "<cmd>Neotest output-panel<cr>", desc = "Output panel" },
    { "<leader>ts", "<cmd>Neotest stop<cr>", desc = "Stop nearest" },
    { "<leader>tt", "<cmd>Neotest summary<cr>", desc = "Toggle summary" },

    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
    {
      mode = { "v" },
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment" },
      { "<leader>f", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>", desc = "Format" }
    }
  }
}

which_key.setup(config)
which_key.add(mappings)

