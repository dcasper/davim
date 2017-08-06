#! /usr/bin/env bash

# Add postgres repo for upgrading to pg 9.6
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    apt-key add -
apt-get update

# Aptitude Installs
apt-get install -y git screen zsh jq npm \
 postgresql-9.6 libpq-dev \
 libssl-dev libreadline-dev zlib1g-dev

# Postgres Setup
su postgres -c "createuser vagrant -dr"
su postgres -c "createdb vagrant"

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

# Install rbenv and plugins/current ruby
su vagrant -c 'git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv'
su vagrant -c 'git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build'
sudo -H -u vagrant zsh -i -c 'rbenv install 2.3.4'
sudo -H -u vagrant zsh -i -c 'rbenv global 2.3.4'
sudo -H -u vagrant zsh -i -c 'gem install rails -v 4.2.6'

# Heroku Toolbelt
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

npm install --global gulp
ln -s /usr/bin/nodejs /usr/bin/node
