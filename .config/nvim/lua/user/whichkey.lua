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
    { "<leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
    { "<leader>dC", "<cmd>lua require('dap').run_to_cursor()<cr>", desc = "Run To Cursor" },
    { "<leader>db", "<cmd>lua require('dap').step_back()<cr>", desc = "Step Back" },
    { "<leader>du", "<cmd>lua require('dap').step_out()<cr>", desc = "Step Out" },
    { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step Into" },
    { "<leader>do", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over" },
    { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue" },
    { "<leader>ds", "<cmd>lua require('dap').continue()<cr>", desc = "Start" },
    { "<leader>dp", "<cmd>lua require('dap').pause()<cr>", desc = "Pause" },
    { "<leader>dg", "<cmd>lua require('dap').session()<cr>", desc = "Get Session" },
    { "<leader>de", "<cmd>lua require('dapui').eval(nil, { enter = true })<cr>", desc = "Eval expression" },
    { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", desc = "Toggle Repl" },
    { "<leader>dU", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle UI" },
    { "<leader>dd", "<cmd>lua require('dap').disconnect()<cr>", desc = "Disconnect" },
    { "<leader>dq", "<cmd>lua require('dap').close()<cr>", desc = "Quit" },
    { "<leader>dT", "<cmd>DapClearBreakpoints<cr>", desc = "Clear Breakpoints" },
    { "<leader>dV", "<cmd>DapVirtualTextToggle<cr>", desc = "Toggle Virtual Text" },

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
    { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>gO", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
    { "<leader>gj", "<cmd>lua require('gitsigns').next_hunk({navigation_message = false})<cr>", desc = "Next Hunk" },
    { "<leader>gk", "<cmd>lua require('gitsigns').prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk" },
    { "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "Blame" },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
    { "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Hunk" },
    { "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Hunk" },
    { "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Hunk" },
    { "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
    { "<leader>ggh", "<cmd>GBrowse<cr>", desc = "Open in GH" },

    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },

    { "<leader>l", group = "LSP"  },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", desc = "Format" },
    { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics" },
    { "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>", desc = "Format" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lt", "<cmd>lua require('treesj').toggle()<cr>", desc = "Split/Join" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>", desc = "Next" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>", desc = "Prev" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Set loc list" },
    { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },

    { "<leader>o", "<cmd>Outline<cr>", desc = "Outline" },

    { "<leader>s", group = "Search" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Text" },
    { "<leader>sT", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = "Text with args" },
    { "<leader>sB", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
    { "<leader>sl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
    { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Find" },

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
      { "<leader>f", "<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>", desc = "Format" },
      {
        "<leader>s", "<cmd>lua require('telescope.builtin').grep_string({ default_text = vim.fn.getreg('\"') })<cr>",
        desc = "Search"
      }
    }
  }
}

which_key.setup(config)
which_key.add(mappings)

