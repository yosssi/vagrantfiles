#!/bin/bash

# Define variables.
BASH_PROFILE=/home/vagrant/.bash_profile
GO_HOME=/host/go

GO_VERSION=go1.3.1
GO_FILE_NAME=$GO_VERSION.linux-amd64.tar.gz

RBENV_SH=/etc/profile.d/rbenv.sh

RUBY_VERSION=2.1.2

RAILS_VERSION=4.2.0.beta1

NODE_VERSION=v0.10.31
NODE_FILE_NAME=node-$NODE_VERSION-linux-x64.tar.gz

# Create .bash_profile
touch $BASH_PROFILE
chown vagrant:vagrant $BASH_PROFILE

apt-get update

# Install curl
apt-get install -y curl

# Install Git
apt-get install -y git

# Install Go
curl -o /usr/local/$GO_FILE_NAME https://storage.googleapis.com/golang/$GO_FILE_NAME
tar -C /usr/local -xzf /usr/local/$GO_FILE_NAME
rm /usr/local/$GO_FILE_NAME
echo "export GOROOT=/usr/local/go" >> $BASH_PROFILE
echo "export GOPATH=$GO_HOME" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$GOPATH/bin\$GOROOT:\$GOROOT/bin" >> $BASH_PROFILE
. $BASH_PROFILE

# Install rbenv
git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
echo '# rbenv setup' > $RBENV_SH
echo "export RBENV_ROOT=/usr/local/rbenv" >> $RBENV_SH
echo "export PATH=\$PATH:\$RBENV_ROOT/bin" >> $RBENV_SH
echo "eval \"\$(rbenv init -)\"" >> $RBENV_SH
chmod +x $RBENV_SH
echo "export RBENV_ROOT=/usr/local/rbenv" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$RBENV_ROOT/bin:\$RBENV_ROOT/shims" >> $BASH_PROFILE
. $BASH_PROFILE

# Install ruby-build
mkdir /usr/local/rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# install packages for building ruby
apt-get install -y git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev

# Install Ruby
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
echo "export PATH=\$PATH:/usr/local/rbenv/versions/$RUBY_VERION/bin" >> $BASH_PROFILE
. $BASH_PROFILE

# Install Bundler
gem install --no-rdoc --no-ri bundler

# Install Rails
gem install --no-rdoc --no-ri rails -v $RAILS_VERSION

# Install Unicorn
gem install --no-rdoc --no-ri unicorn

# Change the owner of /usr/local/rbenv from root to vagrant
chown vagrant:vagrant -R /usr/local/rbenv

# Install Node.js
curl -o /usr/local/lib/$NODE_FILE_NAME  http://nodejs.org/dist/$NODE_VERSION/$NODE_FILE_NAME
tar -C /usr/local/lib -xzf /usr/local/lib/$NODE_FILE_NAME
rm /usr/local/lib/$NODE_FILE_NAME
echo "export NODE_HOME=/usr/local/lib/node-$NODE_VERSION-linux-x64" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$NODE_HOME/bin" >> $BASH_PROFILE
. $BASH_PROFILE

# Install Bower
npm install -g bower

# Install Grunt CLI
npm install -g grunt-cli

# Install Redis
apt-get install -y redis-server

# Install PostgreSQL
 apt-get install -y postgresql postgresql-contrib
