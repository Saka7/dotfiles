local M = {}

local function buffer_map(mode, lhs, rhs, bufnr, desc)
  vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
end

function M.lsp_keymaps(bufnr)
  buffer_map("n", "gD", vim.lsp.buf.declaration, bufnr, "Go to declaration")
  buffer_map("n", "gd", vim.lsp.buf.definition, bufnr, "Go to definition")
  buffer_map("n", "K", vim.lsp.buf.hover, bufnr, "Hover documentation")
  buffer_map("n", "gI", vim.lsp.buf.implementation, bufnr, "Go to implementation")
  buffer_map("n", "gr", vim.lsp.buf.references, bufnr, "List references")
  buffer_map("n", "gl", vim.diagnostic.open_float, bufnr, "Line diagnostics")
end

function M.terminal_keymaps(bufnr)
  buffer_map("t", "<esc>", [[<C-\><C-n>]], bufnr, "Terminal normal mode")
  buffer_map("t", "jk", [[<C-\><C-n>]], bufnr, "Terminal normal mode")
  buffer_map("t", "<C-h>", [[<C-\><C-n><C-W>h]], bufnr, "Go to left window")
  buffer_map("t", "<C-j>", [[<C-\><C-n><C-W>j]], bufnr, "Go to lower window")
  buffer_map("t", "<C-k>", [[<C-\><C-n><C-W>k]], bufnr, "Go to upper window")
  buffer_map("t", "<C-l>", [[<C-\><C-n><C-W>l]], bufnr, "Go to right window")
end

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

    { "<leader>;", "<cmd>Alpha<cr>" },

    { "<leader>a", group = "Agent Context" },
    {
      "<leader>at",
      function()
        require("user.agent_context").copy_selection()
      end,
      mode = { "x" },
      desc = "Copy Selection Context",
    },
    {
      "<leader>af",
      function()
        require("user.agent_context").copy_file()
      end,
      desc = "Copy File Context",
    },
    {
      "<leader>ab",
      function()
        require("user.agent_context").copy_buffers()
      end,
      desc = "Copy Buffer Context",
    },
    {
      "<leader>aB",
      function()
        require("user.agent_context").select_buffers()
      end,
      desc = "Select Buffer Context",
    },

    { "<leader>F", group = "Folds" },
    { "<leader>Fc", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close All" },
    { "<leader>Fo", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open All" },
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
    { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close folds with" },
    { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },

    {
      "<leader>P",
      "<cmd>AutoSession search<cr>",
      desc = "Sessions",
    },

    { "<leader>T", "<cmd>term<cr>", desc = "Terminal new tab" },
    { "<leader>\\", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    { "<c-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "i", "t" } },

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
    {
      "]c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          require("gitsigns").nav_hunk("next", { navigation_message = false })
        end
      end,
      desc = "Next git hunk",
    },
    {
      "[c",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          require("gitsigns").nav_hunk("prev", { navigation_message = false })
        end
      end,
      desc = "Previous git hunk",
    },
    { "<leader>gC", "<cmd>Telescope git_bcommits<cr>" },
    { "<leader>gL", "<cmd>G blame --date=relative<cr>", desc = "Toggle Blame" },
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
      "gmT",
      function()
        require("diffview.actions").conflict_choose_all("theirs")()
      end,
      desc = "Choose THEIRS ALL",
    },

    {
      "gmO",
      function()
        require("diffview.actions").conflict_choose_all("ours")()
      end,
      desc = "Choose OURS ALL",
    },

    {
      "gmP",
      function()
        vim.cmd.update()
        local file = vim.fn.shellescape(vim.fn.expand("%:p"))
        vim.cmd("!mergiraf solve --stdout " .. file)
      end,
      desc = "Preview Mergiraf Solution",
    },

    {
      "gmM",
      function()
        vim.cmd.update()
        local file = vim.fn.shellescape(vim.fn.expand("%:p"))
        vim.cmd("!mergiraf solve " .. file)
        if vim.v.shell_error == 0 then
          vim.cmd.edit({ bang = true })
        end
      end,
      desc = "Solve with Mergiraf",
    },

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
    { "<leader>li", "<cmd>Telescope hierarchy incoming_calls<cr>", desc = "Incoming Calls" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lo", "<cmd>Telescope hierarchy outgoing_calls<cr>", desc = "Outgoing Calls" },
    { "<leader>lt", "<cmd>lua require('treesj').toggle()<cr>", desc = "Split/Join" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>", desc = "Next" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>", desc = "Prev" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Set loc list" },
    { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },

    { "<leader>o", "<cmd>Outline<cr>", desc = "Outline" },

    { "<leader>s", group = "Search" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    {
      "<leader>sT",
      function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          additional_args = {'-g','!tests','-tts','-tjs', '-F'}
        })
      end,
      desc = "Text Args (Selected)",
    },
    { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Text" },
    {
      "<leader>sgt",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({})<cr>",
      desc = "Text Args (Full)",
    },
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
      { "<leader>f", "<cmd>lua require('conform').format({ timeout_ms = 2000 })<cr>", desc = "Format" },
      {
        "<leader>s", "<cmd>lua require('telescope.builtin').grep_string({ default_text = vim.fn.getreg('\"') })<cr>",
        desc = "Search"
      }
    }
  }
}

function M.setup()
  local which_key = require("which-key")
  which_key.setup(config)
  which_key.add(mappings)
end

return M
