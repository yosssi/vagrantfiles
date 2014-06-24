#!/bin/bash

# Define variables.
BASH_PROFILE=/home/vagrant/.bash_profile
GO_HOME=/host/go
GO_FILE_NAME=go1.3.linux-amd64.tar.gz
JAVA_FILE_NAME=jre-7u55-linux-x64.gz
JAVA_DIRECTORY_NAME=jre1.7.0_55
ELASTICSEARCH_DIRECTORY_NAME=elasticsearch-1.1.1
ELASTICSEARCH_FILE_NAME=${ELASTICSEARCH_DIRECTORY_NAME}.tar.gz
RBENV_SH=/etc/profile.d/rbenv.sh

# Create .bash_profile
touch $BASH_PROFILE
chown vagrant:vagrant $BASH_PROFILE

apt-get update

# Install curl
apt-get install -y curl

# Install Git
apt-get install -y git

# Install Go 1.3
curl -o /usr/local/$GO_FILE_NAME https://storage.googleapis.com/golang/$GO_FILE_NAME
tar -C /usr/local -xzf /usr/local/$GO_FILE_NAME
rm /usr/local/$GO_FILE_NAME
echo "export GOROOT=/usr/local/go" >> $BASH_PROFILE
echo "export GOPATH=$GO_HOME" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$GOPATH/bin\$GOROOT:\$GOROOT/bin" >> $BASH_PROFILE
. $BASH_PROFILE

# Install Java 7 Update 55
curl -o /usr/local/lib/$JAVA_FILE_NAME https://s3-ap-northeast-1.amazonaws.com/yosssi/java/$JAVA_FILE_NAME
tar -C /usr/local/lib -xzf /usr/local/lib/$JAVA_FILE_NAME
rm /usr/local/lib/$JAVA_FILE_NAME
echo "export JAVA_HOME=/usr/local/lib/$JAVA_DIRECTORY_NAME" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> $BASH_PROFILE
. $BASH_PROFILE

# Install Elasticsearch 1.1.1
curl -o /usr/local/lib/$ELASTICSEARCH_FILE_NAME https://download.elasticsearch.org/elasticsearch/elasticsearch/$ELASTICSEARCH_FILE_NAME
tar -C /usr/local/lib -xzf /usr/local/lib/$ELASTICSEARCH_FILE_NAME
rm /usr/local/lib/$ELASTICSEARCH_FILE_NAME
echo "export ELASTICSEARCH_HOME=/usr/local/lib/$ELASTICSEARCH_DIRECTORY_NAME" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$ELASTICSEARCH_HOME/bin" >> $BASH_PROFILE
. $BASH_PROFILE
chown vagrant:vagrant -R $ELASTICSEARCH_HOME

# Install Elasticsearch plugins
## Install Marvel
$ELASTICSEARCH_HOME/bin/plugin -i elasticsearch/marvel/latest
## Install elasticsearch-inquisitor
$ELASTICSEARCH_HOME/bin/plugin -i polyfractal/elasticsearch-inquisitor
## Install Japanese (kuromoji) Analysis
$ELASTICSEARCH_HOME/bin/plugin -i elasticsearch/elasticsearch-analysis-kuromoji/2.1.0
## Install elasticsearch-head
$ELASTICSEARCH_HOME/bin/plugin -i mobz/elasticsearch-head

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

# Install Ruby 2.1.2
rbenv install 2.1.2
rbenv global 2.1.2
echo "export PATH=\$PATH:/usr/local/rbenv/versions/2.1.2/bin" >> $BASH_PROFILE
. $BASH_PROFILE

# Install Bundler
gem install --no-rdoc --no-ri bundler

# Install Rails
gem install --no-rdoc --no-ri rails

# Install Unicorn
gem install --no-rdoc --no-ri unicorn

# Change the owner of /usr/local/rbenv from root to vagrant
chown vagrant:vagrant -R /usr/local/rbenv

# Install Node.js v0.10.28
curl -o /usr/local/lib/node-v0.10.28-linux-x64.tar.gz http://nodejs.org/dist/v0.10.28/node-v0.10.28-linux-x64.tar.gz
tar -C /usr/local/lib -xzf /usr/local/lib/node-v0.10.28-linux-x64.tar.gz
rm /usr/local/lib/node-v0.10.28-linux-x64.tar.gz
echo "export NODE_HOME=/usr/local/lib/node-v0.10.28-linux-x64" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$NODE_HOME/bin" >> $BASH_PROFILE
. $BASH_PROFILE

# Install Redis
apt-get install -y redis-server
