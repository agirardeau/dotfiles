local M = {}

M.language_tools = {
  -- Javascript
  {
    name = "prettierd",
    filetype = "javascript",
    category = "formatter",
    mason_package = "prettierd",
  },

  {
    name = "quick-lint-js",
    filetype = "javascript",
    category = "linter",
    mason_package = "quick-lint-js",
  },

  -- Jsonnet
  {
    name = "jsonnetfmt",
    filetype = "jsonnet",
    category = "formatter",
    mason_package = "jsonnetfmt",
    enabled = false,
  },

  {
    name = "jsonnet_ls",
    filetype = "jsonnet",
    category = "language_server",
    mason_package = "jsonnet-language-server",
    enabled = false,
  },

  -- Lua
  {
    name = "stylua",
    filetype = "lua",
    category = "formatter",
    mason_package = "stylua",
  },

  {
    name = "selene",
    filetype = "lua",
    category = "linter",
    mason_package = "selene",
  },

  {
    name = "lua_ls",
    filetype = "lua",
    category = "language_server",
    mason_package = "lua-language-server",
  },

  -- Python
  {
    name = "isort",
    filetype = "python",
    category = "formatter",
    mason_package = "isort",
  },

  {
    name = "black",
    filetype = "python",
    category = "formatter",
    mason_package = "black",
  },

  {
    name = "flake8",
    filetype = "python",
    category = "linter",
    mason_package = "flake8",
  },

  {
    name = "pyright",
    filetype = "python",
    category = "language_server",
    mason_package = "pyright",
  },

  -- Rust
  -- (use rustup to install rust tools instead of mason)
  {
    name = "rustfmt",
    filetype = "rust",
    category = "formatter",
  },

  {
    name = "rust_analyzer",
    filetype = "rust",
    category = "language_server",
  },

  -- Sh
  {
    name = "shfmt",
    filetype = "sh",
    category = "formatter",
    mason_package = "shfmt",
    opts = {
      prepend_args = { "-i", "2" },
    },
  },
}

function M.formatters()
  return vim.tbl_filter(function(tool)
    return tool.category == "formatter" and tool.enabled ~= false
  end, M.language_tools)
end

function M.linters()
  return vim.tbl_filter(function(tool)
    return tool.category == "linter" and tool.enabled ~= false
  end, M.language_tools)
end

function M.language_servers()
  return vim.tbl_filter(function(tool)
    return tool.category == "language_server" and tool.enabled ~= false
  end, M.language_tools)
end

-- Returns a table where keys are filetypes and values are lists of formatter
-- names.
function M.formatter_names_by_filetype()
  local ret = {}
  for _, tool in ipairs(M.formatters()) do
    ret[tool.filetype] = vim.list_extend(ret[tool.filetype] or {}, {tool.name})
  end
  return ret
end

-- Returns a table where keys are the names of formatters and values are opts
-- tables for them.
function M.formatter_opts_by_name()
  local ret = {}
  for _, tool in ipairs(M.formatters()) do
    ret[tool.name] = tool.opts
  end
  return ret
end

-- Returns a table where keys are filetypes and values are lists of linter
-- names.
function M.linter_names_by_filetype()
  local ret = {}
  for _, tool in ipairs(M.linters()) do
    ret[tool.filetype] = vim.list_extend(ret[tool.filetype] or {}, {tool.name})
  end
  return ret
end

-- Returns a list of mason package names.
-- Optionally accepts an opts table with filters, allowed keys are `filetype`
-- and `category`.
function M.mason_packages(opts)
  opts = opts or {}
  local ret = {}
  for _, tool in ipairs(M.language_tools) do
    if tool.mason_package == nil or tool.enabled == false then
      goto continue
    elseif opts.filetype ~= nil and opts.filetype ~= tool.filetype then
      goto continue
    elseif opts.category ~= nil and opts.category ~= tool.category then
      goto continue
    end
    table.insert(ret, tool.mason_package)
    ::continue::
  end
  return ret
end

-- Returns a list of filetypes present in the config.
function M.filetypes()
  local ft_set = {}
  for _, tool in ipairs(M.language_tools) do
    ft_set[tool.filetype] = true
  end
  return vim.tbl_keys(ft_set)
end

M.icons = {
  misc = {
    dots = "󰇘",
  },
  dap = {
    Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint          = " ",
    BreakpointCondition = " ",
    BreakpointRejected  = { " ", "DiagnosticError" },
    LogPoint            = ".>",
  },
  diagnostics = {
    Error = " ",
    Warn  = " ",
    Hint  = " ",
    Info  = " ",
  },
  --git = {
  --  added    = " ",
  --  modified = " ",
  --  removed  = " ",
  --},
  kinds = {
    Array         = " ",
    Boolean       = "󰨙 ",
    Class         = " ",
    Codeium       = "󰘦 ",
    Color         = " ",
    Control       = " ",
    Collapsed     = " ",
    Constant      = "󰏿 ",
    Constructor   = " ",
    Copilot       = " ",
    Enum          = " ",
    EnumMember    = " ",
    Event         = " ",
    Field         = " ",
    File          = " ",
    Folder        = " ",
    Function      = "󰊕 ",
    Interface     = " ",
    Key           = " ",
    Keyword       = " ",
    Method        = "󰊕 ",
    Module        = " ",
    Namespace     = "󰦮 ",
    Null          = " ",
    Number        = "󰎠 ",
    Object        = " ",
    Operator      = " ",
    Package       = " ",
    Property      = " ",
    Reference     = " ",
    Snippet       = " ",
    String        = " ",
    Struct        = "󰆼 ",
    TabNine       = "󰏚 ",
    Text          = " ",
    TypeParameter = " ",
    Unit          = " ",
    Value         = " ",
    Variable      = "󰀫 ",
  },
}

return M