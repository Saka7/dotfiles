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
    {
      "<c-.>",
      "<cmd>lua require('sidekick.cli').focus()<cr>",
      desc = "Sidekick Focus",
      mode = { "n", "t", "i", "x" },
    },

    { "<leader>a", group = "AI" },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle({
          name = "copilot",
          focus = true,
        })
      end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>ad",
      "<cmd>lua require('sidekick.cli').close()<cr>",
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({
          msg = '{this}',
          name = "copilot",
        })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({
          msg = '{file}',
          name = "copilot",
        })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({
          msg = '{selection}',
          name = "copilot",
        })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      "<cmd>lua require('sidekick.cli').prompt()<cr>",
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },

    { "<leader>F", group = "Folds" },
    { "<leader>Fc", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close All" },
    { "<leader>Fo", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open All" },

    {
      "<leader>P",
      function()
        require("telescope").extensions.projects.projects()
      end,
      desc = "Projects",
    },

    { "<leader>T", "<cmd>term<cr>", desc = "Terminal new tab" },
    { "<leader>\\", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },

    { "<leader>b", group = "Buffers" },
    { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
    { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
    { "<leader>be", "<cmd>BufferLinePickClose<cr>", desc = "Pick which buffer to close" },
    { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close others" },
    { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
    { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right" },
    { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Jump" },
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
    {
      "<leader>gj",
      function()
        require("gitsigns").nav_hunk("next", { navigation_message = false })
      end,
      desc = "Next Hunk",
    },
    {
      "<leader>gk",
      function()
        require("gitsigns").nav_hunk("prev", { navigation_message = false })
      end,
      desc = "Prev Hunk",
    },
    { "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "Blame" },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
    { "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Hunk" },
    { "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Hunk" },
    { "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Hunk" },
    { "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
    { "<leader>ggh", "<cmd>GBrowse<cr>", desc = "Open in GH" },

    { "<leader>gm", group = "Merge Conflicts" },
    { "<leader>gmm", "<cmd>DiffviewOpen<cr>", desc = "Open Merge Tool" },
    { "<leader>gmc", "<cmd>DiffviewClose<cr>", desc = "Close Merge Tool" },
    { "<leader>gmf", function() require("diffview.actions").toggle_files() end, desc = "Toggle Files" },

    {
      "<leader>gmo",
      function()
        require("diffview.actions").conflict_choose("ours")()
      end,
      desc = "Choose OURS",
    },

    {
      "<leader>gmt",
      function()
        require("diffview.actions").conflict_choose("theirs")()
      end,
      desc = "Choose THEIRS",
    },

    {
      "<leader>gmb",
      function()
        require("diffview.actions").conflict_choose("base")()
      end,
      desc = "Choose BASE",
    },

    {
      "<leader>gma",
      function()
        require("diffview.actions").conflict_choose_all("all")()
      end,
      desc = "Choose ALL",
    },

    {
      "<leader>gmd",
      function()
        require("diffview.actions").conflict_choose("none")()
      end,
      desc = "Choose NONE",
    },

    {
      "<leader>gmn",
      function()
        require("diffview.actions").next_conflict()
      end,
      desc = "Next Conflict",
    },

    {
      "<leader>gmp",
      function()
        require("diffview.actions").prev_conflict()
      end,
      desc = "Prev Conflict",
    },


    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },

    { "<leader>l", group = "LSP"  },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>lf", "<cmd>lua require('conform').format({ timeout_ms = 2000 })<cr>", desc = "Format" },
    { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", desc = "Buffer Diagnostics" },
    { "<leader>lD", "<cmd>lua require('user.lsp').stop_all()<cr>", desc = "Disable all LSP" },
    { "<leader>lLS", "<cmd>lua require('user.lsp').start_all()<cr>", desc = "Enable all LSP" },
    { "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix" },
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
    {
      "<leader>st",
      function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          additional_args = {'-g','!tests','-tts','-tjs', '-F'}
        })
      end,
      desc = "Text Args (Selected)",
    },
    { "<leader>sT", "<cmd>Telescope live_grep<cr>", desc = "Text" },
    {
      "<leader>sTT",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({})<cr>",
      desc = "Text Args (Full)",
    },
    { "<leader>sB", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },

    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
    { "<leader>sl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
    { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Find" },

    { "<leader>t", group = "Tests" },

    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
    {
      mode = { "v" },
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment" },
      { "<leader>f", "<cmd>lua require('conform').format({ timeout_ms = 2000 })<cr>", desc = "Format" },
      {
        "<leader>s", "<cmd>lua require('telescope.builtin').grep_string({ default_text = vim.fn.getreg('\"') })<cr>",
        desc = "Search"
      }
    }
  }
}

which_key.setup(config)
which_key.add(mappings)
