local excluded_filetypes = {
  [""] = true,
  bigfile = true,
  checkhealth = true,
  gitcommit = true,
  help = true,
  lspinfo = true,
  man = true,
  neogitstatus = true,
  NvimTree = true,
  packer = true,
  startify = true,
  TelescopePrompt = true,
  TelescopeResults = true,
  Trouble = true,
}

local function filter(buf)
  return vim.g.snacks_indent ~= false
    and vim.g.snacks_scope ~= false
    and vim.b[buf].snacks_indent ~= false
    and vim.b[buf].snacks_scope ~= false
    and vim.b[buf].user_bigfile ~= true
    and vim.bo[buf].buftype == ""
    and not excluded_filetypes[vim.bo[buf].filetype]
end

return {
  indent = {
    char = "▏",
  },
  animate = {
    enabled = false,
  },
  scope = {
    char = "▏",
    filter = filter,
    underline = true,
    treesitter = {
      blocks = {
        enabled = true,
        "class",
        "return",
        "function",
        "method",
        "jsx_element",
        "while_statement",
        "for_statement",
        "object",
        "table_constructor",
        "block",
        "arguments",
        "if_statement",
        "else_clause",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "operation_type",
      },
    },
  },
  filter = filter,
}
