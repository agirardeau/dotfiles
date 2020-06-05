" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'micha/vim-colors-solarized'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'
Plug '907th/vim-auto-save'

Plug 'hdima/python-syntax'
Plug 'pangloss/vim-javascript'

Plug 'chrisbra/Recover.vim'

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
