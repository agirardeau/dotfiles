" Load vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    execute '!curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

"Plug 'micha/vim-colors-solarized'
"Plug 'agirardeau/vim-solarized-adjusted'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'
Plug '907th/vim-auto-save'

" Color schemes
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"Plug 'ellisonleao/gruvbox.nvim'  " Requires NVim 0.8
"Plug 'bluz71/vim-moonfly-colors', { 'branch': 'cterm-compat' }  " could remove the cterm-compat branch if I add termguicolors
"Plug 'bluz71/vim-nightfly-colors', { 'branch': 'cterm-compat' }  " could remove the cterm-compat branch if I add termguicolors
"Plug 'jacoborus/tender.vim'
"Plug 'EdenEast/nightfox.nvim'  " Requires NVim 0.8
"Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

"Plug 'hdima/python-syntax'
"Plug 'pangloss/vim-javascript'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'chrisbra/Recover.vim'

Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'ojroques/vim-oscyank', { 'branch': 'main' }

" LSP
Plug 'neovim/nvim-lspconfig' " Collection of common configurations for the Nvim LSP client

" To enable more of the features of rust-analyzer, such as inlay hints and more
Plug 'simrat39/rust-tools.nvim'

" Completion
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }     " Framework
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' } " LSP completion source
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }     " Path completion source
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }   " Buffer completion source
"Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main' }    " Snippet completion source

" To enable more of the features of rust-analyzer, such as inlay hints and more
Plug 'simrat39/rust-tools.nvim'

" Tree sidebar
"Plug 'nvim-tree/nvim-web-devicons'
"Plug 'nvim-tree/nvim-tree.lua'

" Snippet engine
"Plug 'hrsh7th/vim-vsnip'



" Fuzzy finder
"Plug 'nvim-lua/popup.nvim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'

" Plug 'roxma/vim-tmux-clipboard'
" Plug 'digitaltoad/vim-pug'
" Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'scrooloose/nerdtree'
" Plug 'embear/vim-localvimrc'
" Plug 'majutsushi/tagbar'
" Plug 'rbgrouleff/bclose.vim'
" Plug 'tpope/vim-fugitive'
" Plug 'scrooloose/syntastic'
" Plug 'scrooloose/nerdcommenter'
" Plug 'arvandew/supertab'
" Plug 'tpope/vim-surround'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'kien/ctrlp.vim'
" Plug 'Shuogo/unite.vim'
" Plug 'bling/airline'
" Plug 'edkolev/tmuxline.vim'
" Plug 'powerline/powerline'
"

if filereadable($HOME . '/.config/dotfiles/local/plugins-local.vim')
    source $HOME/.config/dotfiles/local/plugins-local.vim
endif

call plug#end()
