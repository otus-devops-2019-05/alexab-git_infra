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


