# Installation

## Quick

    $ curl https://raw.githubusercontent.com/abencz/vim_config/master/bin/install.sh | sh

## Slow

Get the repository:

    $ git clone --recursive https://github.com/abencz/vim_config.git ~/.vim

Symlink vimrc:

    $ ln -sf ~/.vim/vimrc ~/.vimrc

Update bundles:

    $ vim +NeoBundleInstall +qall
