
-- Store .swp files in /tmp
vim.opt.backupdir = "/tmp//"
vim.opt.directory = "/tmp//"

-- Enable syntax highlighting
--vim.opt.background = "dark"

-- Split creation
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Word wrapping
vim.opt.wrap = false

-- Clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- AutoSave (vim-auto-save)
vim.g.auto_save = 1  -- enable AutoSave on Vim startup
vim.g.auto_save_silent = 1  -- do not display the AutoSave notification
vim.g.auto_save_events = {"InsertLeave", "TextChanged", "CursorHoldI"}

-- Set completeopt to have a better completion experience (:help completeopt)
--  menuone: popup even when there's only one match
--  noinsert: Do not insert text until a selection is made
--  noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = "filnxtToOFc"

-- Overlay diagnostic signs on top of line numbers instead of making the line
-- number bar wider
vim.opt.signcolumn = "number"
vim.diagnostic.config({
  underline = {
    severity = "warn",
  },
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    source = "if_many",
    spacing = 12,
  },
  severity_sort = true,
  float = {
    border = "single",
    format = function(diagnostic)
      return string.format(
        "%s (%s) [%s]",
        diagnostic.message,
        diagnostic.source,
        diagnostic.code or diagnostic.user_data.lsp.code
      )
    end,
  },
})

-- Use case insensitive search, except when using capital letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Instead of failing a command because of unsaved changes, instead raise a
-- dialogue asking if you wish to save changed files.
vim.opt.confirm = true

-- Use visual bell instead of beeping when doing something wrong
vim.opt.visualbell = true

-- Enable use of the mouse for all modes
vim.opt.mouse = "a"

-- Display line numbers on the left
vim.opt.number = true

-- Quickly time out on keycodes, but never time out on mappings
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200

-- Default to inserting 2 spaces instead of tabs.
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Prevent loading certain vim features
local disabled_built_ins = {
  "2html_plugin",
  "tohtml",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

