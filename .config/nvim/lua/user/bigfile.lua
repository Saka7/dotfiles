local M = {}

M.size = 5 * 1024 * 1024
M.line_length = 1000

local function restore_features(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  local filetype = vim.b[buf].user_bigfile_filetype
  if not filetype or filetype == "" then
    return
  end

  vim.b[buf].completion = true
  vim.b[buf].user_bigfile = false
  vim.bo[buf].filetype = filetype
  vim.schedule(function()
    local gitsigns = package.loaded.gitsigns
    if gitsigns then
      gitsigns.attach({ bufnr = buf, force = true })
    end
  end)
  vim.notify("Enabled full features for this buffer", vim.log.levels.INFO, { title = "Big File" })
end

function M.setup(ctx)
  if vim.fn.exists(":NoMatchParen") ~= 0 then
    vim.cmd([[NoMatchParen]])
  end

  vim.b[ctx.buf].completion = false
  vim.b[ctx.buf].user_bigfile = true
  vim.b[ctx.buf].user_bigfile_filetype = ctx.ft

  Snacks.util.wo(0, {
    conceallevel = 0,
    foldmethod = "manual",
    statuscolumn = "",
  })

  vim.api.nvim_buf_create_user_command(ctx.buf, "BigfileEnable", function()
    restore_features(ctx.buf)
  end, { desc = "Enable full features for this large buffer", force = true })

  vim.schedule(function()
    if vim.api.nvim_buf_is_valid(ctx.buf) then
      vim.bo[ctx.buf].syntax = ctx.ft
      local gitsigns = package.loaded.gitsigns
      if gitsigns then
        gitsigns.detach(ctx.buf)
      end
    end
  end)
end

return M
