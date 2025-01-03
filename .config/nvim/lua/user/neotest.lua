require('neotest').setup({
  discovery = {
		enabled = false,
	},
  summary = {
    open = 'leftabove vsplit | vertical resize 50'
  },
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --",
      env = { CI = true, TZ = "UTC" },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  }
})

