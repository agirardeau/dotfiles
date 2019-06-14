" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'micha/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'chrisbra/Recover.vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'

Plug 'hdima/python-syntax'
Plug 'pangloss/vim-javascript'

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
call plug#end()
