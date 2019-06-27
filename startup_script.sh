#!/bin/bash

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

COMMAND='ruby -v'
if echo $COMMAND | grep -q 'command not found'; then
	echo "error: ruby installation failuire"
else
	echo "ruby installation is successfull"
fi

COMMAND='bundler -v'
if echo $COMMAND | grep -q 'command not found'; then
	echo "error: bundler installation failuire"
else
	echo "bundler installation is successfull"
fi

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

COMMAND='systemctl status mongod'

if $COMMAND | grep -q 'active (running)'; then
	echo "mongod is up and running"
else
	echo "mongod: installation failure"
fi


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


