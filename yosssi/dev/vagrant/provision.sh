#!/bin/bash

# Make sure the package repository is up to date
echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
apt-get update

# Install curl
apt-get install -y curl
