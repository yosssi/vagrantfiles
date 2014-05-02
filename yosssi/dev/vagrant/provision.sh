#!/bin/bash

# Define variables.
BASH_PROFILE=/home/vagrant/.bash_profile
GO_HOME=/host/go

# Create .bash_profile
touch $BASH_PROFILE
chown vagrant:vagrant $BASH_PROFILE

# Make sure the package repository is up to date
echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
apt-get update

# Install curl
apt-get install -y curl

# Install Go 1.3beta1
curl -o /usr/local/go1.3beta1.linux-amd64.tar.gz https://storage.googleapis.com/golang/go1.3beta1.linux-amd64.tar.gz
tar -C /usr/local -xzf /usr/local/go1.3beta1.linux-amd64.tar.gz
rm /usr/local/go1.3beta1.linux-amd64.tar.gz
echo "export GOROOT=/usr/local/go" >> $BASH_PROFILE
echo "export GOPATH=$GO_HOME" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$GOPATH/bin\$GOROOT:\$GOROOT/bin" >> $BASH_PROFILE

# Install Java 7 Update 55
curl -o /usr/local/lib/jre-7u51-linux-x64.tar.gz https://s3-ap-northeast-1.amazonaws.com/yosssi/java/jre-7u55-linux-x64.gz
tar -C /usr/local/lib -xzf /usr/local/lib/jre-7u51-linux-x64.tar.gz
rm /usr/local/lib/jre-7u51-linux-x64.tar.gz
echo "export JAVA_HOME=/usr/local/lib/jre1.7.0_55" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> $BASH_PROFILE

# Install Elasticsearch 1.1.1
curl -o /usr/local/lib/elasticsearch-1.1.1.tar.gz https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz
tar -C /usr/local/lib -xzf /usr/local/lib/elasticsearch-1.1.1.tar.gz
rm /usr/local/lib/elasticsearch-1.1.1.tar.gz
echo "export ELASTICSEARCH_HOME=/usr/local/lib/elasticsearch-1.1.1" >> $BASH_PROFILE
echo "export PATH=\$PATH:\$ELASTICSEARCH_HOME/bin" >> $BASH_PROFILE
chmod 777 /usr/local/lib/elasticsearch-1.1.1
