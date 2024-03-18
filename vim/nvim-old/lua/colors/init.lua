local M = {}

local links = {}
if vim.version().major >= 1 or vim.version().minor >= 8 then
  -- treesitter
  vim.tbl_extend("error", links, {
    ["@comment"] = { link = "Comment" },
    ["@error"] = { link = "Error" },
    ["@none"] = { bg = "NONE", fg = "NONE" },
    ["@preproc"] = { link = "PreProc" },
    ["@define"] = { link = "Define" },
    ["@operator"] = { link = "Operator" },
    ["@punctuation.delimiter"] = { link = "Delimiter" },
    ["@punctuation.bracket"] = { link = "Delimiter" },
    ["@punctuation.special"] = { link = "Delimiter" },
    ["@string"] = { link = "String" },
    ["@string.regex"] = { link = "String" },
    ["@string.escape"] = { link = "SpecialChar" },
    ["@string.special"] = { link = "SpecialChar" },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { link = "SpecialChar" },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@float"] = { link = "Float" },
    ["@function"] = { link = "Function" },
    ["@function.call"] = { link = "Function" },
    ["@function.builtin"] = { link = "Special" },
    ["@function.macro"] = { link = "Macro" },
    ["@method"] = { link = "Function" },
    ["@method.call"] = { link = "Function" },
    ["@constructor"] = { link = "Special" },
    ["@parameter"] = { link = "Identifier" },
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.function"] = { link = "Keyword" },
    ["@keyword.operator"] = { link = "Keyword" },
    ["@keyword.return"] = { link = "Keyword" },
    ["@conditional"] = { link = "Conditional" },
    ["@repeat"] = { link = "Repeat" },
    ["@debug"] = { link = "Debug" },
    ["@label"] = { link = "Label" },
    ["@include"] = { link = "Include" },
    ["@exception"] = { link = "Exception" },
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { link = "Type" },
    ["@type.qualifier"] = { link = "Type" },
    ["@type.definition"] = { link = "Typedef" },
    ["@storageclass"] = { link = "StorageClass" },
    ["@attribute"] = { link = "PreProc" },
    ["@field"] = { link = "Identifier" },
    ["@property"] = { link = "Function" },
    ["@variable"] = { link = "Normal" },
    ["@variable.builtin"] = { link = "Special" },
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { link = "Special" },
    ["@constant.macro"] = { link = "Define" },
    ["@namespace"] = { link = "Include" },
    ["@symbol"] = { link = "Identifier" },
    ["@text"] = { link = "Normal" },
    ["@text.strong"] = { bold = true },
    ["@text.emphasis"] = { italic = true },
    ["@text.underline"] = { underline = true },
    ["@text.strike"] = { strikethrough = true },
    ["@text.title"] = { link = "Title" },
    ["@text.literal"] = { link = "String" },
    ["@text.uri"] = { link = "Underlined" },
    ["@text.math"] = { link = "Special" },
    ["@text.environment"] = { link = "Macro" },
    ["@text.environment.name"] = { link = "Type" },
    ["@text.reference"] = { link = "Constant" },
    ["@text.todo"] = { link = "Todo" },
    ["@text.note"] = { link = "Todo" },  -- Todo: link to something more specific than "Todo" if possible
    ["@text.warning"] = { link = "Todo" },
    ["@text.danger"] = { link = "Todo" },
    ["@tag"] = { link = "Tag" },
    ["@tag.attribute"] = { link = "Identifier" },
    ["@tag.delimiter"] = { link = "Delimiter" },
  })

  -- lsp semantic tokens
  vim.tbl_extend("error", links, {
    LspNamespace = { link = "@namespace" },
    LspType = { link = "@type" },
    LspClass = { link = "@type" },
    LspEnum = { link = "@constant" },
    LspInterface = { link = "@constant" },
    LspStruct = { link = "@constant" },
    LspTypeParameter = { link = "@type" },
    LspParameter = { link = "@parameter" },
    LspVariable = { link = "@variable" },
    LspProperty = { link = "@property" },
    LspEnumMember = { link = "@constant" },
    LspEvent = { link = "@constant" },
    LspFunction = { link = "@function" },
    LspMethod = { link = "@method" },
    LspMacro = { link = "@constant.macro" },
    LspKeyword = { link = "@keyword" },
    LspModifier = { link = "TSModifier" },
    LspComment = { link = "@comment" },
    LspString = { link = "@string" },
    LspNumber = { link = "@number" },
    LspRegexp = { link = "@string.regex" },
    LspOperator = { link = "@operator" },
    LspDecorator = { link = "@symbol" },
    LspDeprecated = { link = "@text.strike" },
  })
end

local function load_terminal_colors(terminal)
  for i, c in pairs(terminal) do
    vim.g["terminal_color_" .. i] = c
  end
end

local function load_highlights(highlights)
  for group_name, group_settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group_name, group_settings)
  end
end

local function load_links()
  load_highlights(links)
end

function M.set_colorscheme(name)
  local scheme = require("colors." .. name)

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  load_terminal_colors(scheme.terminal)
  load_links()
  load_highlights(scheme.highlights.predef)
  load_highlights(scheme.highlights.common)
  load_highlights(scheme.highlights.syntax)
  for _, group in pairs(scheme.highlights.langs) do
    load_highlights(group)
  end
  for _, group in pairs(scheme.highlights.plugins) do
    load_highlights(group)
  end

  vim.g.colors_name = name
  vim.o.background = scheme.background
  vim.o.termguicolors = scheme.termguicolors
end

return M
