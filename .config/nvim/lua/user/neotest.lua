require('neotest').setup({
  discovery = {
		enabled = false,
	},
  summary = {
    open = 'leftabove vsplit | vertical resize 50'
  },
  adapters = {
    require('neotest-jest')({
      jest_test_discovery = false,
      jestCommand = "npm test --",
      env = { CI = true, TZ = "UTC" },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  }
})

