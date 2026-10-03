local M = {}
local jest = require("user.jest")

function M.jest_root(path)
  return jest.resolve(path).root
end

local jest_adapter = require("neotest-jest")({
  jest_test_discovery = false,
  jestCommand = "npm test --",
  env = { CI = true, TZ = "UTC" },
  cwd = M.jest_root,
  jestConfigFile = function(path)
    return jest.resolve(path).config or ""
  end,
  isTestFile = require("neotest-jest.util").defaultTestFileMatcher,
})

jest_adapter.root = M.jest_root

require("neotest").setup({
  discovery = {
    enabled = false,
  },
  summary = {
    open = "leftabove vsplit | vertical resize 50",
  },
  adapters = { jest_adapter },
})

return M
