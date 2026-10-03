vim.cmd.packadd("nvim.undotree")

if vim.fn.exists(":Undotree") ~= 2 then
  error("Neovim's nvim.undotree package did not define :Undotree")
end

vim.api.nvim_del_user_command("Undotree")
vim.api.nvim_create_user_command("Undotree", function()
  require("undotree").open({ command = "topleft 30vnew" })
end, { desc = "Toggle the native undo tree on the left" })
