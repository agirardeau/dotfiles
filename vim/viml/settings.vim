"------------------------------------------------------------
" User created settings

" Store .swp files in /tmp
set backupdir=/tmp//
set directory=/tmp//

" Enable syntax highlighting
"syntax enable
"set syntax=c.doxygen
set background=dark
set t_Co=256
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"

" Split creation
"  from: http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Word wrapping
set nowrap
set sidescroll=1

" clipboard
set clipboard^=unnamed,unnamedplus

" AutoSave (vim-auto-save)
let g:auto_save = 1 " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the AutoSave notification
let g:auto_save_events = ["InsertLeave", "TextChanged", "CursorHoldI"]

" Set completeopt to have a better completion experience (:help completeopt)
"   menuone: popup even when there's only one match
"   noinsert: Do not insert text until a selection is made
"   noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

"------------------------------------------------------------
" Settings from internet {{{1
" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell
set noerrorbells

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=4
set expandtab

"------------------------------------------------------------
" Settings for plugin `simrat39/rust-tools`

lua <<EOF
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
EOF

"------------------------------------------------------------
" Settings for plugin `hrsh7th/nvim-cmp`

lua <<EOF
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
EOF

"----------------------------------------------------------
" Settings for plugin `nvim-treesitter`

lua <<EOF
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

EOF

"----------------------------------------------------------
" Settings for plugin `folke/tokyonight.nvim`

lua <<EOF
util = require("tokyonight.util")
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

EOF
colorscheme tokyonight

