#!/usr/bin/env bash

echo "Deleting existing ~/.vim folder..."
rm -rf ~/.vim

echo "Setting up file structure..."
mkdir ~/.vim
mkdir ~/.vim/autoload
mkdir ~/.vim/bundle

echo "Downloading latest version of pathogen.vim..."
cd ~/.vim/autoload
wget -P ~/.vim/autoload -nv \
        https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim




