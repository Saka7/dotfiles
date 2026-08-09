local opts = { silent = true }
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

--Remap space as leader key
map("", "<Space>", "<Nop>", "Disable space")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
map("n", "<C-h>", "<C-w>h", "Go to left window")
map("n", "<C-j>", "<C-w>j", "Go to lower window")
map("n", "<C-k>", "<C-w>k", "Go to upper window")
map("n", "<C-l>", "<C-w>l", "Go to right window")

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", "Decrease window height")
map("n", "<C-Down>", ":resize +2<CR>", "Increase window height")
map("n", "<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
map("n", "<C-Right>", ":vertical resize +2<CR>", "Increase window width")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", "Next buffer")
map("n", "<S-h>", ":bprevious<CR>", "Previous buffer")

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down")
map("n", "<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up")

-- Insert --
-- Press jk fast to exit insert mode 
map("i", "jk", "<ESC>", "Exit insert mode")
map("i", "kj", "<ESC>", "Exit insert mode")
map("i", "jj", "<Esc>", "Exit insert mode")

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", "Move selection down")
map("v", "<A-k>", ":m .-2<CR>==", "Move selection up")
map("v", "p", '"_dP', "Paste without yanking")

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", "Move block down")
map("x", "K", ":move '<-2<CR>gv-gv", "Move block up")
map("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move block down")
map("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move block up")
