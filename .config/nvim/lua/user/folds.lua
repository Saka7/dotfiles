local M = {}

local treesitter_foldexpr = "v:lua.vim.treesitter.foldexpr()"
local lsp_foldexpr = "v:lua.vim.lsp.foldexpr()"

local function supports_lsp_folds(buf)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
    if client:supports_method("textDocument/foldingRange", buf) then
      return true
    end
  end
  return false
end

local function configure_window(win)
  if not vim.api.nvim_win_is_valid(win) or vim.wo[win].diff then
    return
  end

  local buf = vim.api.nvim_win_get_buf(win)
  local buftype = vim.bo[buf].buftype
  if (buftype ~= "" and buftype ~= "acwrite") or vim.b[buf].user_bigfile then
    return
  end

  vim.wo[win].foldmethod = "expr"
  vim.wo[win].foldexpr = supports_lsp_folds(buf) and lsp_foldexpr or treesitter_foldexpr
  vim.wo[win].foldtext = ""
end

local function configure_buffer(buf)
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    configure_window(win)
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("_native_folds", { clear = true })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType", "LspAttach", "LspDetach" }, {
    group = group,
    callback = function(ev)
      vim.schedule(function()
        configure_buffer(ev.buf)
      end)
    end,
  })

  vim.api.nvim_create_autocmd("SessionLoadPost", {
    group = group,
    callback = function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        configure_window(win)
      end
    end,
  })

  configure_window(vim.api.nvim_get_current_win())
end

return M
