#!/bin/bash

git clone --recursive https://github.com/abencz/vim_config.git ~/.vim
ln -sf ~/.vim/init.vim ~/.vimrc

# support for NeoVim
mkdir -p ~/.config
ln -sf ~/.vim ~/.config/nvim

vim +NeoBundleInstall +qall
