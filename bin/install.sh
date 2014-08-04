#!/bin/bash

git clone --recursive https://github.com/abencz/vim_config.git ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc

vim +NeoBundleInstall +qall
