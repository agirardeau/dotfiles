#!/usr/bin/env bash

echo "Removing existing plugins..."
rm -rf ~/.vim/bundle/*

git clone git://github.com/altercation/vim-colors-solarized ~/.vim/bundle/solarized
# git clone git://github.com/majutsushi/tagbar ~/.vim/bundle/tagbar
git clone git://github.com/scrooloose/nerdtree ~/.vim/bundle/nerdtree
git clone git://github.com/hdima/python-syntax ~/.vim/bundle/python
git clone git://github.com/chrisbra/Recover.vim ~/.vim/bundle/recover
git clone git://github.com/Glench/Vim-Jinja2-Syntax ~/.vim/bundle/jinja2
git clone git://github.com/godlygeek/tabular.git ~/.vim/bundle/tabular

# git clone git://github.com/rbgrouleff/bclose.vim ~/.vim/bundle/bclose
# git clone git://github.com/tpope/vim-fugitive ~/.vim/bundle/fugitive
# git clone git://github.com/scrooloose/syntastic ~/.vim/bundle/syntastic
# git clone git://github.com/scrooloose/nerdcommenter ~/.vim/bundle/nerdcommenter
# git clone git://github.com/arvandew/supertab ~/.vim/bundle/supertab
# git clone git://github.com/tpope/vim-surround ~/.vim/bundle/surround
# git clone git://github.com/Lokaltog/vim-easymotion ~/.vim/bundle/easymotion

# git clone git://github.com/kien/ctrlp.vim ~/.vim/bundle/ctrlp
# git clone git://github.com/Shuogo/unite.vim ~/.vim/bundle/unite

# git clone git://github.com/bling/airline ~/.vim/bundle/airline
# git clone git://github.com/edkolev/tmuxline.vim ~/.vim/bundle/tmuxline
# git clone git://github.com/powerline/powerline ~/.vim/bundle/powerline


