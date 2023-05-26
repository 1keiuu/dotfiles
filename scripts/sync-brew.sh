#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS"
	exit 1
fi

# install brew packages
brew bundle --global

nodebrew setup
