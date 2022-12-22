local p = require("colors.tokyodark.palette")

local predef = {
  Fg = { fg = p.fg },
  Grey = { fg = p.grey },
  Red = { fg = p.red },
  Orange = { fg = p.orange },
  Yellow = { fg = p.yellow },
  Green = { fg = p.green },
  Blue = { fg = p.blue },
  Purple = { fg = p.purple },
  --BlueItalic = { fg = p.blue, italic = true },
  --GreenItalic = { fg = p.green, italic = true },
  --OrangeItalic = { fg = p.orange, italic = true },
  --RedItalic = { fg = p.red, italic = true },
  --YellowItalic = { fg = p.yellow, italic = true },
}

local common = {
  Normal = { fg = p.fg, bg = p.bg0 },
  NormalNC = { fg = p.fg, bg = p.bg0 },
  NormalSB = { fg = p.fg, bg = p.bg0 },
  NormalFloat = { fg = p.fg, bg = p.bg0 },
  Terminal = { fg = p.fg, bg = p.bg0 },
  EndOfBuffer = { fg = p.bg2, bg = p.bg0 },
  FoldColumn = { fg = p.fg, bg = p.bg1 },
  Folded = { fg = p.fg, bg = p.bg1 },
  SignColumn = { fg = p.fg, bg = p.bg0 },
  ToolbarLine = { fg = p.fg },
  Cursor = { reverse = true },
  vCursor = { reverse = true },
  iCursor = { reverse = true },
  lCursor = { reverse = true },
  CursorIM = { reverse = true },
  CursorColumn = { bg = p.bg1 },
  CursorLine = { bg = p.bg1 },
  ColorColumn = { bg = p.bg1 },
  CursorLineNr = { fg = p.fg },
  LineNr = { fg = p.bg4 },
  Conceal = { fg = p.grey, bg = p.bg1 },
  DiffAdd = { fg = p.none, bg = p.diff_add },
  DiffChange = { fg = p.none, bg = p.diff_change },
  DiffDelete = { fg = p.none, bg = p.diff_delete },
  DiffText = { fg = p.none, bg = p.diff_text },
  Directory = { fg = p.green },
  ErrorMsg = { fg = p.red, bold = true, underline = true },
  WarningMsg = { fg = p.yellow, bold = true },
  MoreMsg = { fg = p.blue, bold = true },
  IncSearch = { fg = p.bg0, bg = p.bg_red },
  Search = { fg = p.bg0, bg = p.bg_green },
  CurSearch = { fg = p.bg0, bg = p.bg_red },
  MatchParen = { fg = p.none, bg = p.bg4 },
  NonText = { fg = p.bg4 },
  Whitespace = { fg = p.bg4 },
  SpecialKey = { fg = p.bg4 },
  Pmenu = { fg = p.fg, bg = p.bg0 },
  PmenuSbar = { fg = p.none, bg = p.bg0 },
  PmenuSel = { fg = p.bg0, bg = p.bg_green },
  PmenuThumb = { fg = p.none, bg = p.bg2 },
  WildMenu = { fg = p.bg0, bg = p.blue },
  Question = { fg = p.yellow },
  SpellBad = { fg = p.red, underline = true, sp = p.red },
  SpellCap = { fg = p.yellow, underline = true, sp = p.yellow },
  SpellLocal = { fg = p.blue, underline = true, sp = p.blue },
  SpellRare = { fg = p.purple, underline = true, sp = p.purple },
  StatusLine = { fg = p.fg, bg = p.bg2 },
  StatusLineTerm = { fg = p.fg, bg = p.bg2 },
  StatusLineNC = { fg = p.grey, bg = p.bg1 },
  StatusLineTermNC = { fg = p.grey, bg = p.bg1 },
  TabLine = { fg = p.fg, bg = p.bg4 },
  TabLineFill = { fg = p.grey, bg = p.bg1 },
  TabLineSel = { fg = p.bg0, bg = p.bg_red },
  VertSplit = { fg = p.bg5 },
  Visual = { bg = p.bg2 },
  VisualNOS = { fg = p.none, bg = p.bg2, underline = true },
  QuickFixLine = { fg = p.blue, underline = true },
  Debug = { fg = p.yellow },
  debugPC = { fg = p.bg0, bg = p.green },
  debugBreakpoint = { fg = p.bg0, bg = p.red },
  ToolbarButton = { fg = p.bg0, bg = p.bg_blue },
  FocusedSymbol = { bg = p.bg3 },
}

local syntax = {
  Type = predef.Blue,
  Structure = predef.Blue,
  StorageClass = predef.Blue,
  Identifier = predef.Orange,
  Constant = predef.Orange,
  --Type = predef.BlueItalic,
  --Structure = predef.BlueItalic,
  --StorageClass = predef.BlueItalic,
  --Identifier = predef.OrangeItalic,
  --Constant = predef.OrangeItalic,
  PreProc = predef.Red,
  PreCondit = predef.Red,
  Include = predef.Red,
  Keyword = predef.Red,
  Define = predef.Red,
  Typedef = predef.Red,
  Exception = predef.Red,
  Conditional = predef.Red,
  Repeat = predef.Red,
  Statement = predef.Red,
  Macro = predef.Purple,
  Error = predef.Red,
  Label = predef.Purple,
  Special = predef.Purple,
  SpecialChar = predef.Purple,
  Boolean = predef.Purple,
  String = predef.Yellow,
  Character = predef.Yellow,
  Number = predef.Purple,
  Float = predef.Purple,
  Function = predef.Green,
  Operator = predef.Red,
  Title = predef.Yellow,
  Tag = predef.Orange,
  Delimiter = predef.Fg,
  Comment = { fg = p.bg4 },
  SpecialComment = { fg = p.bg4 },
  Todo = { fg = p.blue },
  DiagnosticError = { fg = p.diagnostic_red },
  DiagnosticHint = { fg = p.diagnostic_purple },
  DiagnosticInfo = { fg = p.diagnostic_blue },
  DiagnosticWarn = { fg = p.diagnostic_yellow },
}

local plugins = {}
--plugins.lsp = {
--    LspCxxHlGroupEnumConstant = predef.Orange,
--    LspCxxHlGroupMemberVariable = predef.Orange,
--    LspCxxHlGroupNamespace = predef.Blue,
--    LspCxxHlSkippedRegion = predef.Grey,
--    LspCxxHlSkippedRegionBeginEnd = predef.Red,
--    LspDiagnosticsDefaultError = { fg = p.diagnostic_red },
--    LspDiagnosticsDefaultHint = { fg = p.diagnostic_purple },
--    LspDiagnosticsDefaultInformation = { fg = p.diagnostic_blue },
--    LspDiagnosticsDefaultWarning = { fg = p.diagnostic_yellow },
--    LspDiagnosticsUnderlineError = { underline = true, sp = p.diagnostic_red },
--    LspDiagnosticsUnderlineHint = { underline = true, sp = p.diagnostic_purple },
--    LspDiagnosticsUnderlineInformation = { underline = true, sp = p.diagnostic_blue },
--    LspDiagnosticsUnderlineWarning = { underline = true, sp = p.diagnostic_yellow },
--    DiagnosticSignError = { fg = p.diagnostic_red },
--    DiagnosticSignHint = { fg = p.diagnostic_purple },
--    DiagnosticSignInfo = { fg = p.diagnostic_blue },
--    DiagnosticSignWarn = { fg = p.diagnostic_yellow },
--    LspReferenceRead = { bg = p.bg3 },
--    LspReferenceWrite = { bg = p.bg3 },
--    LspReferenceText = { bg = p.bg3 },
--    LspInfoBorder = { fg = p.bg4 },
--}

--plugins.whichkey = {
--    WhichKey = predef.Red,
--    WhichKeyDesc = predef.Blue,
--    WhichKeyGroup = predef.Orange,
--    WhichKeySeperator = predef.Green,
--}
--
--plugins.gitgutter = {
--    GitGutterAdd = { fg = p.diff_green },
--    GitGutterChange = { fg = p.diff_blue },
--    GitGutterDelete = { fg = p.diff_red },
--}
--
--plugins.diffview = {
--    DiffviewFilePanelTitle = { fg = p.blue, bold = true },
--    DiffviewFilePanelCounter = { fg = p.purple, bold = true },
--    DiffviewFilePanelFileName = predef.Fg,
--    DiffviewNormal = common.Normal,
--    DiffviewCursorLine = common.CursorLine,
--    DiffviewVertSplit = common.VertSplit,
--    DiffviewSignColumn = common.SignColumn,
--    DiffviewStatusLine = common.StatusLine,
--    DiffviewStatusLineNC = common.StatusLineNC,
--    DiffviewEndOfBuffer = common.EndOfBuffer,
--    DiffviewFilePanelRootPath = predef.Grey,
--    DiffviewFilePanelPath = predef.Grey,
--    DiffviewFilePanelInsertions = predef.Green,
--    DiffviewFilePanelDeletions = predef.Red,
--    DiffviewStatusAdded = predef.Green,
--    DiffviewStatusUntracked = predef.Blue,
--    DiffviewStatusModified = predef.Blue,
--    DiffviewStatusRenamed = predef.Blue,
--    DiffviewStatusCopied = predef.Blue,
--    DiffviewStatusTypeChange = predef.Blue,
--    DiffviewStatusUnmerged = predef.Blue,
--    DiffviewStatusUnknown = predef.Red,
--    DiffviewStatusDeleted = predef.Red,
--    DiffviewStatusBroken = predef.Red,
--}

--plugins.treesitter = {
--    commentTSDanger = predef.RedItalic,
--    commentTSNote = predef.BlueItalic,
--    commentTSWarning = predef.YellowItalic,
--}

--plugins.cmp = {
--    CmpItemKindDefault = { fg = p.blue, bg = p.none },
--    CmpItemAbbrMatch = { fg = p.blue, bg = p.none },
--    CmpItemAbbrMatchFuzzy = { fg = p.blue, bg = p.none },
--
--    CmpItemKindKeyword = { fg = p.fg, bg = p.none },
--
--    CmpItemKindVariable = { fg = p.cyan, bg = p.none },
--    CmpItemKindConstant = { fg = p.cyan, bg = p.none },
--    CmpItemKindReference = { fg = p.cyan, bg = p.none },
--    CmpItemKindValue = { fg = p.cyan, bg = p.none },
--
--    CmpItemKindFunction = { fg = p.purple, bg = p.none },
--    CmpItemKindMethod = { fg = p.purple, bg = p.none },
--    CmpItemKindConstructor = { fg = p.purple, bg = p.none },
--
--    CmpItemKindClass = { fg = p.yellow, bg = p.none },
--    CmpItemKindInterface = { fg = p.yellow, bg = p.none },
--    CmpItemKindStruct = { fg = p.yellow, bg = p.none },
--    CmpItemKindEvent = { fg = p.yellow, bg = p.none },
--    CmpItemKindEnum = { fg = p.yellow, bg = p.none },
--    CmpItemKindUnit = { fg = p.yellow, bg = p.none },
--    CmpItemKindModule = { fg = p.yellow, bg = p.none },
--
--    CmpItemKindProperty = { fg = p.green, bg = p.none },
--    CmpItemKindField = { fg = p.green, bg = p.none },
--    CmpItemKindTypeParameter = { fg = p.green, bg = p.none },
--    CmpItemKindEnumMember = { fg = p.green, bg = p.none },
--    CmpItemKindOperator = { fg = p.green, bg = p.none },
--
--    CmpItemKindSnippet = { fg = p.red, bg = p.none },
--}
--
--plugins.coc = {
--    CocErrorSign = { fg = p.diagnostic_red },
--    CocHintSign = { fg = p.diagnostic_red },
--    CocInfoSign = { fg = p.diagnostic_red },
--    CocWarningSign = { fg = p.diagnostic_red },
--    FgCocErrorFloatBgCocFloating = { fg = p.diagnostic_red, bg = p.bg2 },
--    FgCocHintFloatBgCocFloating = { fg = p.diagnostic_purple, bg = p.bg2 },
--    FgCocInfoFloatBgCocFloating = { fg = p.diagnostic_blue, bg = p.bg2 },
--    FgCocWarningFloatBgCocFloating = { fg = p.diagnostic_yellow, bg = p.bg2 },
--}
--
--plugins.gitsigns = {
--    GitSignsAdd = predef.Green,
--    GitSignsAddLn = predef.Green,
--    GitSignsAddNr = predef.Green,
--    GitSignsChange = predef.Blue,
--    GitSignsChangeLn = predef.Blue,
--    GitSignsChangeNr = predef.Blue,
--    GitSignsDelete = predef.Red,
--    GitSignsDeleteLn = predef.Red,
--    GitSignsDeleteNr = predef.Red,
--}


local langs = {}
--langs.markdown = {
--    markdownBlockquote = predef.Grey,
--    markdownBold = { fg = p.none, bold = true },
--    markdownBoldDelimiter = predef.Grey,
--    markdownCode = predef.Yellow,
--    markdownCodeBlock = predef.Yellow,
--    markdownCodeDelimiter = predef.Green,
--    markdownH1 = { fg = p.red, bold = true },
--    markdownH2 = { fg = p.red, bold = true },
--    markdownH3 = { fg = p.red, bold = true },
--    markdownH4 = { fg = p.red, bold = true },
--    markdownH5 = { fg = p.red, bold = true },
--    markdownH6 = { fg = p.red, bold = true },
--    markdownHeadingDelimiter = predef.Grey,
--    markdownHeadingRule = predef.Grey,
--    markdownId = predef.Yellow,
--    markdownIdDeclaration = predef.Red,
--    markdownItalic = { fg = p.none, italic = true },
--    markdownItalicDelimiter = { fg = p.grey, italic = true },
--    markdownLinkDelimiter = predef.Grey,
--    markdownLinkText = predef.Red,
--    markdownLinkTextDelimiter = predef.Grey,
--    markdownListMarker = predef.Red,
--    markdownOrderedListMarker = predef.Red,
--    markdownRule = predef.Purple,
--    markdownUrl = { fg = p.blue, underline = true },
--    markdownUrlDelimiter = predef.Grey,
--    markdownUrlTitleDelimiter = predef.Green,
--}
--
--langs.scala = {
--    scalaNameDefinition = predef.Fg,
--    scalaInterpolationBoundary = predef.Purple,
--    scalaInterpolation = predef.Purple,
--    scalaTypeOperator = predef.Red,
--    scalaOperator = predef.Red,
--    scalaKeywordModifier = predef.Red,
--}

--local function load_sync()
--    load_highlights(predef)
--    load_highlights(common)
--    load_highlights(syntax)
--    for _, group in pairs(langs) do
--        load_highlights(group)
--    end
--    for _, group in pairs(plugins) do
--        load_highlights(group)
--    end
--end
--
--function M.setup()
--    load_sync()
--end

return {
  predef = predef,
  common = common,
  syntax = syntax,
  plugins = plugins,
  langs = langs,
}

