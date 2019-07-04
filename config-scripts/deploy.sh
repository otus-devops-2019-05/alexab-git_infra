#!/bin/bash


cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd ~/reddit
bundle install

puma -d

COMMAND='ps aux'

if $COMMAND | grep -q "[p]uma"; then
	echo "puma is up and running"
else
	echo "puma: installation failure"
fi


