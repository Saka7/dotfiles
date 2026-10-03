return {
  keymap = require("user.keymaps").blink,
  appearance = {
    nerd_font_variant = "normal",
  },
  completion = {
    documentation = {
      window = {
        border = "rounded",
      },
    },
    menu = {
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "source_name" },
        },
      },
    },
  },
  sources = {
    default = { "lsp", "snippets", "buffer", "path" },
    providers = {
      lsp = { name = "[LSP]", fallbacks = {} },
      snippets = { name = "[Snippet]" },
      buffer = { name = "[Buffer]" },
      path = { name = "[Path]" },
    },
  },
  cmdline = {
    enabled = false,
  },
}
