#!/bin/bash


cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd ~/reddit
bundle install

puma -d

COMMAND='ps aux'

if $COMMAND | grep -q "[p]uma"; then
	echo "mongod is up and running"
else
	echo "mongod: installation failure"
fi


