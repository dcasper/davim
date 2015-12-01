#! /usr/bin/env bash

# Aptitude Installs
apt-get update
apt-get install -y git screen zsh npm

# Get RVM hooked up and on its feet
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source /home/vagrant/.rvm/scripts/rvm
sudo chmod a+rw -R /usr/local/rvm/

# Oh My Zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git
mv oh-my-zsh .oh-my-zsh
chsh -s `which zsh` vagrant

# Davim Config
git clone https://github.com/dcasper/davim
ln -s davim/.vim .vim
ln -s davim/.vimrc .vimrc
ln -s davim/.zshrc .zshrc
ln -s davim/.zshenv .zshenv
ln -s davim/.screenrc .screenrc

# Heroku Toolbelt
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

npm install --global gulp
ln -s /usr/bin/nodejs /usr/bin/node
