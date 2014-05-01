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
