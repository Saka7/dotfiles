local function load(module)
  local ok, result = pcall(require, module)
  if not ok then
    error(("Failed to load %s: %s"):format(module, result))
  end
  return result
end

load("user.options")
load("user.keymaps").setup()
load("user.agent_context").setup()
load("user.session").setup()
load("user.plugins")
load("user.folds").setup()
load("user.undo")
load("user.colorscheme")
load("user.statusline").setup()

load("user.autocommands")
