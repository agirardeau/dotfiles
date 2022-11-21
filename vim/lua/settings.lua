
-- Store .swp files in /tmp
vim.opt.backupdir = "/tmp//"
vim.opt.directory = "/tmp//"

-- Enable syntax highlighting
vim.opt.background = "dark"
--vim.opt.t_Co = 256

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

-- Indentation settings for using 2 spaces instead of tabs.
-- Do not change 'tabstop' from its default value of 8 with this setup? 
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 4
vim.opt.expandtab = true


--------------------------------------------------------------
-- Settings for plugin `simrat39/rust-tools`

local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        --hover_with_actions = true,  -- deprecated, suggested to set keybind to :RustHoverActions in on_attach instead
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

--------------------------------------------------------------
-- Settings for plugin `hrsh7th/nvim-cmp`

local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    --{ name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

------------------------------------------------------------
-- Settings for plugin `nvim-treesitter`

nvim_treesitter_configs = require'nvim-treesitter.configs'
nvim_treesitter_configs.setup({
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'diff',
    'gitattributes',
    'gitignore',
    'help',
    'html',
    'javascript',
    'json',
    'lua',
    'make',
    'markdown',
    'python',
    'rust',
    'sql',
    'toml',
    'vim',
    'yaml',
  },

  disable = function(lang, buf)
    local max_filesize = 500 * 1024 -- 500 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,

  highlight = {
    enable = true,
  },

})

------------------------------------------------------------
-- Settings for plugin `folke/tokyonight.nvim`

require("tokyonight.util")
require("tokyonight").setup({
  -- use the night style
  style = "night",
  -- disable italic for keywords
  styles = {
    keywords = { italic = false }
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    local charcoal = "#161616"
    local darker_charcoal = "#121212"
    local darkest_charcoal = "#040404"
    local lighter_charcoal = "#404040"

    colors.bg = charcoal
    colors.bg_dark = darker_charcoal
    colors.terminal_black = darker_charcoal
    colors.bg_dark = darker_charcoal
    colors.comment = "#6A6A6A"
    colors.black = darkest_charcoal
    colors.bg_popup = darker_charcoal
    colors.bg_search = darker_charcoal
    colors.bg_sidebar = darker_charcoal
    colors.bg_visual = lighter_charcoal
  end,
  terminal_colors = true,
})

vim.cmd("colorscheme tokyonight")



