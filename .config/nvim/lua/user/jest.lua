local M = {}

local config_files = {
  "jest.config.js",
  "jest.config.cjs",
  "jest.config.mjs",
  "jest.config.ts",
  "jest.config.cts",
  "jest.config.mts",
  "jest.config.json",
}

local function read_package(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end
  local contents = file:read("*a")
  file:close()
  if not contents then
    return nil
  end
  local decoded_ok, package = pcall(vim.json.decode, contents)
  return decoded_ok and type(package) == "table" and package or nil
end

local function uses_jest(package)
  for _, field in ipairs({ "dependencies", "devDependencies" }) do
    if type(package[field]) == "table" and package[field].jest ~= nil then
      return true
    end
  end

  for _, command in pairs(type(package.scripts) == "table" and package.scripts or {}) do
    if type(command) == "string" and command:find("jest", 1, true) then
      return true
    end
  end

  return false
end

function M.resolve(path)
  path = path or vim.api.nvim_buf_get_name(0)
  local start = vim.fs.normalize(vim.fn.fnamemodify(path ~= "" and path or vim.fn.getcwd(), ":p"))
  if vim.fn.isdirectory(start) == 0 then
    start = vim.fs.dirname(start)
  end

  local nearest_package, jest_package
  local directory = start
  while directory do
    for _, name in ipairs(config_files) do
      local config = vim.fs.joinpath(directory, name)
      if vim.fn.filereadable(config) == 1 then
        return { root = directory, config = config }
      end
    end

    local package_path = vim.fs.joinpath(directory, "package.json")
    if vim.fn.filereadable(package_path) == 1 then
      nearest_package = nearest_package or directory
      local package = read_package(package_path)
      if package then
        if package.jest ~= nil and package.jest ~= vim.NIL then
          return { root = directory, config = package_path }
        end
        if not jest_package and uses_jest(package) then
          jest_package = directory
        end
      end
    end

    local parent = vim.fs.dirname(directory)
    if parent == directory then
      break
    end
    directory = parent
  end

  return { root = jest_package or nearest_package or vim.fs.root(start, ".git") or start }
end

return M
