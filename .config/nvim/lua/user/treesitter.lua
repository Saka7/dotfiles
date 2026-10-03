local parsers = {
  "bash",
  "c",
  "css",
  "glimmer",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "tsx",
  "typescript",
  "yaml",
}

local treesitter = require("nvim-treesitter")
treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(event.buf, lang)
    end
  end,
})
