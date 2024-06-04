local M = {}

local language_tools = {
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

  -- Json
  {
    name = "jsonlint",
    filetype = "json",
    category = "linter",
    mason_package = "jsonlint",
  },

  -- Jsonnet
  -- Requires Go to be installed
  {
    name = "jsonnetfmt",
    filetype = "jsonnet",
    category = "formatter",
    mason_package = "jsonnetfmt",
  },

  {
    name = "jsonnet_ls",
    filetype = "jsonnet",
    category = "language_server",
    mason_package = "jsonnet-language-server",
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
    -- Disabled since configuring path to selene.toml config file is difficult,
    -- see https://github.com/Kampfkarren/selene/issues/526. Also, the lua lsp
    -- seems to do a good enough job of diagnostics.
    enabled = false,
  },

  {
    name = "lua_ls",
    filetype = "lua",
    category = "language_server",
    mason_package = "lua-language-server",
  },

  -- Markdown
  {
    name = "vale",
    filetype = "markdown",
    category = "linter",
    mason_package = "vale",
    enabled = false,
  },

  -- Nushell
  {
    name = "nushell",
    filetype = "nu",
    category = "language_server",
    opts = {
      cmd = {"nu", "-n", "--lsp"},  -- -n flag ignores user config when running lsp
    },
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

  -- Text
  {
    name = "vale",
    filetype = "text",
    category = "linter",
    mason_package = "vale",
    enabled = false,
  },
}

local function extend_filters(base, new)
  return vim.tbl_extend("force", base or {}, new or {})
end

-- Return a filtered list of defined language toos.
-- opts:
--   enabled: If set, only include tools with matching `enabled` value
--   filetype:  If set, only include tools with matching `filetype` value
--   category: If set, only include tools with matching `category` value
--   is_managed: If set, only include tools with matching tool.mason_package ~= nil
--   predicate: If set, only include tools where predicate(tool) == true
--   sort: If true, sort the output using default order
function M.language_tools(opts)
  opts = opts or {}
  local ret = {}
  for _, tool in ipairs(language_tools) do
    if (opts.enabled == nil or (tool.enabled ~= false) == opts.enabled)
        and (opts.filetype == nil or tool.filetype == opts.filetype)
        and (opts.category == nil or tool.category == opts.category)
        and (opts.is_managed == nil or (tool.mason_package ~= nil) == opts.is_managed)
        and (opts.predicate == nil or opts.predicate(tool)) then
      table.insert(ret, vim.tbl_extend("keep", tool, {
        enabled = true,
        opts = {},
      }))
    end
  end
  local order_category = function(category)
    if category == "formatter" then return 1
    elseif category == "linter" then return 2
    elseif category == "language_server" then return 3
    elseif category == "debug_adapter" then return 4
    else return 5
    end
  end
  if opts.sort == true then
    table.sort(ret, function(a, b)
      if a.filetype < b.filetype then
        return true
      elseif a.filetype > b.filetype then
        return false
      elseif order_category(a.category) < order_category(b.category) then
        return true
      elseif order_category(a.category) > order_category(b.category) then
        return false
      else
        return a.name < b.name
      end
    end)
  elseif type(opts.sort) == "function" then
    table.sort(ret, opts.sort)
  elseif opts.sort ~= nil and opts.sort ~= false then
    vim.print("Unrecognized value for opts.sort in data.language_tools()")
  end
  return ret
end

function M.formatters(filters)
  return M.language_tools(vim.tbl_extend("keep", filters or {}, {
    category = "formatter",
  }))
end

function M.formatters_enabled(filters)
  return M.formatters(vim.tbl_extend("keep", filters or {}, {
    enabled = true,
  }))
end

function M.linters(filters)
  return M.language_tools(vim.tbl_extend("keep", filters or {}, {
    category = "linter",
  }))
end

function M.linters_enabled(filters)
  return M.linters(vim.tbl_extend("keep", filters or {}, {
    enabled = true,
  }))
end

function M.language_servers(filters)
  return M.language_tools(vim.tbl_extend("keep", filters or {}, {
    category = "language_server",
  }))
end

function M.language_servers_enabled(filters)
  return M.language_servers(vim.tbl_extend("keep", filters or {}, {
    enabled = true,
  }))
end

function M.debug_adapters(filters)
  return M.language_tools(vim.tbl_extend("keep", filters or {}, {
    category = "debug_adapter",
  }))
end

function M.debug_adapters_enabled(filters)
  return M.debug_adapters(vim.tbl_extend("keep", filters or {}, {
    enabled = true,
  }))
end

-- Returns a table where keys are filetypes and values are lists of formatter
-- names.
function M.formatter_names_by_filetype(filters)
  local ret = {}
  for _, tool in ipairs(M.formatters(filters)) do
    ret[tool.filetype] = vim.list_extend(ret[tool.filetype] or {}, {tool.name})
  end
  return ret
end

function M.enabled_formatter_names_by_filetype(filters)
  return M.formatter_names_by_filetype(vim.tbl_extend("keep", filters or {}, {
    enabled = true,
  }))
end

-- Returns a table where keys are the names of formatters and values are opts
-- tables for them.
function M.formatter_opts_by_name(filters)
  local ret = {}
  for _, tool in ipairs(M.formatters(filters)) do
    ret[tool.name] = tool.opts
  end
  return ret
end

function M.enabled_formatter_opts_by_name(filters)
  return M.formatter_opts_by_name(vim.tbl_extend("keep", filters or {}, {
    enabled = true,
  }))
end

-- Returns a table where keys are filetypes and values are lists of linter
-- names.
function M.linter_names_by_filetype(filters)
  local ret = {}
  for _, tool in ipairs(M.linters(filters)) do
    ret[tool.filetype] = vim.list_extend(ret[tool.filetype] or {}, {tool.name})
  end
  return ret
end

function M.enabled_linter_names_by_filetype(filters)
  return M.linter_names_by_filetype(vim.tbl_extend("keep", filters or {}, {
    enabled = true,
  }))
end

-- Returns a list of mason package names.
function M.mason_package_names(filters)
  local pkg_set = {}
  for _, tool in ipairs(M.language_tools(filters)) do
    if tool.mason_package ~= nil then
      pkg_set[tool.mason_package] = true
    end
  end
  return vim.tbl_keys(pkg_set)
end

function M.enabled_mason_package_names(filters)
  return M.mason_package_names(vim.tbl_extend("keep", filters or {}, {
    enabled = true,
  }))
end

-- Returns a list of filetypes present in the config.
function M.filetypes()
  local ft_set = {}
  for _, tool in ipairs(language_tools) do
    ft_set[tool.filetype] = true
  end
  local ft_list = vim.tbl_keys(ft_set)
  table.sort(ft_list)
  return ft_list
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
