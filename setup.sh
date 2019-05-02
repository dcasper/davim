git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Must be run from the config source dir
davim=$(pwd)
cd ~
ln -s $davim/.vim .vim
ln -s $davim/.vimrc .vimrc
ln -s $davim/.screenrc .screenrc
ln -s $davim/.zshenv .zshenv
ln -s $davim/.zshrc .zshrc
