local M = {}

local opts = { silent = true }
local function map(mode, lhs, rhs, desc, extra)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }, extra or {}))
end

-- Editor mappings are installed before lazy.nvim reads plugin keys.
function M.setup()
  -- Remap space as leader key
  map("", "<Space>", "<Nop>", "Disable space")
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  map("n", "<leader>c", "<cmd>bdelete<cr>", "Close buffer")
  map(
    "n",
    "<leader>h",
    "<cmd>nohlsearch<cr><cmd>lua if package.loaded.scrollview then require('scrollview').refresh() end<cr>",
    "Clear search highlight"
  )

  -- Normal --
  -- Better window navigation
  map("n", "<C-h>", "<C-w>h", "Go to left window")
  map("n", "<C-j>", "<C-w>j", "Go to lower window")
  map("n", "<C-k>", "<C-w>k", "Go to upper window")
  map("n", "<C-l>", "<C-w>l", "Go to right window")

  -- Resize with arrows
  map("n", "<C-Up>", "<cmd>resize -2<cr>", "Decrease window height")
  map("n", "<C-Down>", "<cmd>resize +2<cr>", "Increase window height")
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")

  -- Navigate buffers
  map("n", "<S-l>", "<cmd>bnext<cr>", "Next buffer")
  map("n", "<S-h>", "<cmd>bprevious<cr>", "Previous buffer")

  -- Move text up and down
  map("n", "<A-j>", "<cmd>move .+1<cr>==gi", "Move line down")
  map("n", "<A-k>", "<cmd>move .-2<cr>==gi", "Move line up")

  -- Insert --
  -- Press jk fast to exit insert mode
  map("i", "jk", "<ESC>", "Exit insert mode")
  map("i", "kj", "<ESC>", "Exit insert mode")
  map("i", "jj", "<Esc>", "Exit insert mode")

  -- Visual --
  -- Stay in indent mode
  map("x", "<", "<gv", "Indent left")
  map("x", ">", ">gv", "Indent right")
  map("x", "p", '"_dP', "Paste without yanking")
  map("x", "J", ":move '>+1<CR>gv-gv", "Move block down")
  map("x", "K", ":move '<-2<CR>gv-gv", "Move block up")
  map("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move selection down")
  map("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move selection up")

  map("n", "<leader>u", "<cmd>Undotree<cr>", "Undo tree")
  map("x", "<leader>at", function()
    require("user.agent_context").copy_selection()
  end, "Copy selection context")
  map("n", "<leader>af", function()
    require("user.agent_context").copy_file()
  end, "Copy file context")
  map("n", "<leader>ab", function()
    require("user.agent_context").copy_buffers()
  end, "Copy buffer context")
  map("n", "<leader>aB", function()
    require("user.agent_context").select_buffers()
  end, "Select buffer context")
end

-- Plugin shortcuts stay in lazy.nvim keys specs to preserve lazy loading.
M.plugins = {}

M.plugins.snacks = {
  {
    "<leader>z",
    function()
      Snacks.zen()
    end,
    desc = "Toggle Zen mode",
  },
  {
    "<leader>ggh",
    function()
      Snacks.gitbrowse()
    end,
    mode = { "n", "x" },
    desc = "Open in Git browser",
  },
}

M.plugins.treesj = {
  {
    "<leader>lt",
    function()
      require("treesj").toggle()
    end,
    desc = "Split or join",
  },
}

M.plugins.bufferline = {
  { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort buffers by directory" },
  { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
  { "<leader>be", "<cmd>BufferLinePickClose<cr>", desc = "Pick buffer to close" },
  { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
  { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
  { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
  { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
  { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
}

M.plugins.hlslens = {
  { "*", "*<cmd>lua require('hlslens').start()<cr>", desc = "Search word forward" },
  { "#", "#<cmd>lua require('hlslens').start()<cr>", desc = "Search word backward" },
  { "g*", "g*<cmd>lua require('hlslens').start()<cr>", desc = "Search partial word forward" },
  { "g#", "g#<cmd>lua require('hlslens').start()<cr>", desc = "Search partial word backward" },
}

M.plugins.nvim_tree = {
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
}

M.plugins.outline = {
  { "<leader>o", "<cmd>Outline<cr>", desc = "Outline" },
}

M.plugins.telescope = {
  {
    "<leader>f",
    function()
      require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({
        previewer = false,
        borderchars = require("telescope.config").pickers.find_files.borderchars,
      }))
    end,
    desc = "Find files",
  },
  { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find buffer" },
  { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer commits" },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Changed files" },
  { "<leader>sB", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  {
    "<leader>sT",
    function()
      require("telescope").extensions.live_grep_args.live_grep_args({
        additional_args = { "-g", "!tests", "-tts", "-tjs", "-F" },
      })
    end,
    desc = "Text arguments with filters",
  },
  { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Text" },
  {
    "<leader>sgt",
    function()
      require("telescope").extensions.live_grep_args.live_grep_args({})
    end,
    desc = "Text arguments",
  },
  { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find file" },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
  { "<leader>sl", "<cmd>Telescope resume<cr>", desc = "Resume search" },
  {
    "<leader>sm",
    function()
      local make_entry = require("telescope.make_entry").gen_from_marks({})
      require("telescope.builtin").marks({
        entry_maker = function(item)
          if item.line:sub(1, 1):match("[A-Za-z]") then
            return make_entry(item)
          end
        end,
      })
    end,
    desc = "Marks",
  },
  { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  {
    "<leader>s",
    function()
      vim.cmd.normal({ '"zy', bang = true })
      require("telescope.builtin").grep_string({ default_text = vim.fn.getreg("z") })
    end,
    mode = "x",
    desc = "Search selection",
  },
}

M.plugins.gitsigns = {
  {
    "]c",
    function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        require("gitsigns").nav_hunk("next", { navigation_message = false })
      end
    end,
    desc = "Next Git hunk",
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
    desc = "Previous Git hunk",
  },
  {
    "<leader>gL",
    function()
      require("gitsigns").blame()
    end,
    desc = "Blame file",
  },
  {
    "<leader>gR",
    function()
      require("gitsigns").reset_buffer()
    end,
    desc = "Reset buffer",
  },
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git diff" },
  {
    "<leader>gj",
    function()
      require("gitsigns").nav_hunk("next", { navigation_message = false })
    end,
    desc = "Next hunk",
  },
  {
    "<leader>gk",
    function()
      require("gitsigns").nav_hunk("prev", { navigation_message = false })
    end,
    desc = "Previous hunk",
  },
  {
    "<leader>gl",
    function()
      require("gitsigns").blame_line()
    end,
    desc = "Blame line",
  },
  {
    "<leader>gp",
    function()
      require("gitsigns").preview_hunk()
    end,
    desc = "Preview hunk",
  },
  {
    "<leader>gr",
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "Reset hunk",
  },
  {
    "<leader>gs",
    function()
      require("gitsigns").stage_hunk()
    end,
    desc = "Stage or unstage hunk",
  },
  {
    "<leader>gu",
    function()
      require("gitsigns").stage_hunk()
    end,
    desc = "Unstage hunk at cursor",
  },
}

M.plugins.diffview = {
  {
    "<leader>gD",
    function()
      require("diffview.actions").open_in_diffview()
    end,
    desc = "Open commit diff",
  },
  { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
  { "<leader>gH", "<cmd>'<,'>DiffviewFileHistory<cr>", mode = "x", desc = "Line history" },
  { "<leader>gO", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
  { "<leader>gmm", "<cmd>DiffviewOpen<cr>", desc = "Open merge tool" },
  { "<leader>gmc", "<cmd>DiffviewClose<cr>", desc = "Close merge tool" },
  {
    "<leader>gmf",
    function()
      require("diffview.actions").toggle_files()
    end,
    desc = "Toggle files",
  },
  {
    "<leader>gmT",
    function()
      require("diffview.actions").conflict_choose_all("theirs")()
    end,
    desc = "Choose theirs for all conflicts",
  },
  {
    "<leader>gmO",
    function()
      require("diffview.actions").conflict_choose_all("ours")()
    end,
    desc = "Choose ours for all conflicts",
  },
  {
    "<leader>gmo",
    function()
      require("diffview.actions").conflict_choose("ours")()
    end,
    desc = "Choose ours",
  },
  {
    "<leader>gmt",
    function()
      require("diffview.actions").conflict_choose("theirs")()
    end,
    desc = "Choose theirs",
  },
  {
    "<leader>gmb",
    function()
      require("diffview.actions").conflict_choose("base")()
    end,
    desc = "Choose base",
  },
  {
    "<leader>gma",
    function()
      require("diffview.actions").conflict_choose_all("all")()
    end,
    desc = "Choose all versions",
  },
  {
    "<leader>gmd",
    function()
      require("diffview.actions").conflict_choose("none")()
    end,
    desc = "Delete conflict region",
  },
  {
    "<leader>gmn",
    function()
      require("diffview.actions").next_conflict()
    end,
    desc = "Next conflict",
  },
  {
    "<leader>gmp",
    function()
      require("diffview.actions").prev_conflict()
    end,
    desc = "Previous conflict",
  },
}

M.plugins.conform = {
  {
    "<leader>lf",
    function()
      require("conform").format({ timeout_ms = 2000 })
    end,
    mode = { "n", "x" },
    desc = "Format",
  },
}

M.plugins.neotest = {
  { "<leader>tL", '<cmd>Neotest run last strategy="dap"<cr>', desc = "Debug last test" },
  { "<leader>tO", "<cmd>Neotest output<cr>", desc = "Test output" },
  { "<leader>ta", "<cmd>Neotest attach<cr>", desc = "Attach to nearest test" },
  { "<leader>td", '<cmd>Neotest run strategy="dap"<cr>', desc = "Debug nearest test" },
  { "<leader>tf", "<cmd>Neotest run file<cr>", desc = "Run test file" },
  { "<leader>tl", "<cmd>Neotest run last<cr>", desc = "Run last test" },
  { "<leader>tn", "<cmd>Neotest run<cr>", desc = "Run nearest test" },
  { "<leader>to", "<cmd>Neotest output-panel<cr>", desc = "Test output panel" },
  { "<leader>ts", "<cmd>Neotest stop<cr>", desc = "Stop nearest test" },
  { "<leader>tt", "<cmd>Neotest summary<cr>", desc = "Toggle test summary" },
}

M.plugins.dap = {
  {
    "<leader>dt",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "Toggle breakpoint",
  },
  {
    "<leader>dC",
    function()
      require("dap").run_to_cursor()
    end,
    desc = "Run to cursor",
  },
  {
    "<leader>db",
    function()
      require("dap").step_back()
    end,
    desc = "Step back",
  },
  {
    "<leader>du",
    function()
      require("dap").step_out()
    end,
    desc = "Step out",
  },
  {
    "<leader>di",
    function()
      require("dap").step_into()
    end,
    desc = "Step into",
  },
  {
    "<leader>do",
    function()
      require("dap").step_over()
    end,
    desc = "Step over",
  },
  {
    "<leader>dc",
    function()
      require("dap").continue()
    end,
    desc = "Continue",
  },
  {
    "<leader>ds",
    function()
      require("dap").continue()
    end,
    desc = "Start debugger",
  },
  {
    "<leader>dp",
    function()
      require("dap").pause()
    end,
    desc = "Pause",
  },
  {
    "<leader>de",
    function()
      require("dapui").eval(nil, { enter = true })
    end,
    desc = "Evaluate expression",
  },
  {
    "<leader>dr",
    function()
      require("dap").repl.toggle()
    end,
    desc = "Toggle debug REPL",
  },
  {
    "<leader>dU",
    function()
      require("dapui").toggle()
    end,
    desc = "Toggle debug UI",
  },
  {
    "<leader>dd",
    function()
      require("dap").disconnect()
    end,
    desc = "Disconnect debugger",
  },
  {
    "<leader>dq",
    function()
      require("dap").close()
    end,
    desc = "Close debugger",
  },
  { "<leader>dT", "<cmd>DapClearBreakpoints<cr>", desc = "Clear breakpoints" },
}

-- Global LSP actions are registered when language tooling initializes.
function M.setup_lsp()
  map("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols")
  map("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer diagnostics")
  map("n", "<leader>lD", function()
    require("user.lsp").disable_all()
  end, "Disable automatic LSP")
  map("n", "<leader>lLS", function()
    require("user.lsp").enable_all()
  end, "Enable automatic LSP")
  map("n", "<leader>le", "<cmd>Telescope quickfix<cr>", "Quickfix list")
  map("n", "<leader>li", "<cmd>Telescope hierarchy incoming_calls<cr>", "Incoming calls")
  map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols")
  map("n", "<leader>lo", "<cmd>Telescope hierarchy outgoing_calls<cr>", "Outgoing calls")
  map("n", "<leader>lq", vim.diagnostic.setloclist, "Set location list")
  map("n", "<leader>lw", "<cmd>Telescope diagnostics<cr>", "Workspace diagnostics")
end

-- These mappings belong only to buffers with an attached LSP client.
function M.attach_lsp(bufnr)
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration", { buf = bufnr })
  map("n", "gd", vim.lsp.buf.definition, "Go to definition", { buf = bufnr })
  map("n", "gl", vim.diagnostic.open_float, "Line diagnostics", { buf = bufnr })
end

function M.attach_special_buffer(bufnr)
  map("n", "q", "<cmd>close<cr>", nil, { buf = bufnr })
end

-- Which-key reads descriptions from bindings; only group labels live here.
M.groups = {
  { "<leader>a", group = "Agent Context" },
  { "<leader>b", group = "Buffers" },
  { "<leader>d", group = "Debug" },
  { "<leader>g", group = "Git" },
  { "<leader>gm", group = "Merge Conflicts" },
  { "<leader>l", group = "LSP" },
  { "<leader>s", group = "Search" },
  { "<leader>t", group = "Tests" },
}

-- Completion and picker controls use their plugins' own mapping schemas.
local function check_backspace()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

M.blink = {
  preset = "none",
  ["<C-k>"] = { "select_prev", "fallback" },
  ["<C-j>"] = { "select_next", "fallback" },
  ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  ["<C-Space>"] = { "show" },
  ["<C-y>"] = {
    function()
      return true
    end,
  },
  ["<C-e>"] = { "cancel", "fallback" },
  ["<CR>"] = { "select_and_accept", "fallback" },
  ["<Tab>"] = {
    "select_next",
    "snippet_forward",
    function(cmp)
      if not check_backspace() then
        cmp.show()
        return true
      end
    end,
    "fallback",
  },
  ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
}

function M.telescope()
  local actions = require("telescope.actions")
  return {
    i = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-A-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    },
    n = {
      ["<C-A-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    },
  }
end

return M
