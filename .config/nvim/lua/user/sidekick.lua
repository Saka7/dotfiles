require("sidekick").setup({
  nes = {
    enabled = false,
    debounce = 80,
    diff = { inline = "words", show = "always" },
  },

  cli = {
    win = {
      layout = "right",
    },
    mux = {
      enabled = true,
      backend = "tmux",
    },
    tools = {
      copilot = {
        cmd = { 'copilot' },
      },
    },
  },
})

