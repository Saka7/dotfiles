local options = {
  clipboard = "unnamedplus",
  cmdheight = 2,
  completeopt = { "menuone", "noselect" },
  fileencoding = "utf-8",
  ignorecase = true,
  mouse = "a",
  mousemoveevent = true,
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  timeoutlen = 200,
  undofile = true,
  updatetime = 200,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  signcolumn = "yes",
  linebreak = true,
  scrolloff = 8,
  sessionoptions = {
    "blank",
    "buffers",
    "curdir",
    "folds",
    "help",
    "tabpages",
    "winsize",
    "winpos",
    "localoptions",
  },
  sidescrolloff = 8,
  -- Use a Nerd Font so icon glyphs from devicons, bufferline, and the statusline render correctly in GUI clients.
  guifont = "DroidSansM Nerd Font:h17",
  whichwrap = "bs<>[]hl",
  foldcolumn = "1",
  foldlevel = 99,
  foldlevelstart = 99,
  colorcolumn = "120",
  winborder = "rounded",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("linematch:60")
