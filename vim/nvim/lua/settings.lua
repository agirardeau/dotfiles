
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
vim.opt.breakindent = true
vim.opt.breakindentopt = "list:2"
vim.opt.formatlistpat = "^\\s*[>*] "

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

-- Change how wildcard expansion on the command line works
vim.opt.wildmode = "longest:full,full"

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

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

-- Highlight the line the cursor is currently on
vim.opt.cursorline = true

-- Keep lines above and below cursor visible when scrolling to the top/bottom
-- of the buffer
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 8

-- Add a border to floating windows
vim.opt.winborder = "rounded"

-- Enable concealed text (folding?)
--vim.opt.conceallevel = 2
--vim.opt.vim_json_conceal = 0 -- Otherwise this hides quotes in json :S

-- Quickly time out on keycodes, but never time out on mappings
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200

-- Default to inserting 2 spaces instead of tabs.
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true  -- round to multiple of shiftwidth when indenting 

-- Automatically indent when starting new lines based on curly braces
vim.opt.smartindent = true

-- Automatic addition of comment headers, formatting of numbered lists
vim.opt.formatoptions = "tcqjron"  -- default is "tcqj"

-- Use ripgrep, set custom output format
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"  -- default is "%f:%l:%m,%f:%l%m,%f  %l%m"

-- Maximum number of items in the popup menu
vim.opt.pumheight = 10  -- default 0 (unbounded)

-- Allow moving the cursor to move where there is no text in visual block mode
vim.opt.virtualedit = "block"

-- Keep the same line at the top of the window when creating a split
vim.opt.splitkeep = "topline"

-- Characters to fill special lines in the window
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Fold based on indentation
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99  -- start with folds open

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

-- Treat empty filetype as `text`
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  pattern = "*",
  -- TODO: Only run this for extensionless files
  -- Not sure why the below pattern doesn't work, asked on reddit at
  -- https://www.reddit.com/r/neovim/comments/1o67m2v/comment/nji4zow/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  --pattern = "^[^.]*$",
  callback = function()
    local ft = vim.filetype.match({ buf = 0 })
    --print("THIS RAN! FT = " .. (ft or "") .. ", NEW FT = " .. (ft or "text"))
    -- Set filetype event if we aren't setting a default value of `text`. Otherwise filetype
    -- detection would run again, wasting cycles.
    vim.bo.filetype = ft or "text"
  end,
})

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

