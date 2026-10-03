local schemas = {
  {
    description = "TypeScript compiler configuration",
    fileMatch = { "tsconfig.json", "tsconfig.*.json" },
    url = "https://json.schemastore.org/tsconfig.json",
  },
  {
    description = "Babel configuration",
    fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
    url = "https://json.schemastore.org/babelrc.json",
  },
  {
    description = "ESLint configuration",
    fileMatch = { ".eslintrc", ".eslintrc.json" },
    url = "https://json.schemastore.org/eslintrc.json",
  },
  {
    description = "Prettier configuration",
    fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
    url = "https://json.schemastore.org/prettierrc",
  },
  {
    description = "Node package manifest",
    fileMatch = { "package.json" },
    url = "https://json.schemastore.org/package.json",
  },
}

return {
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
    },
  },
}
