#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS"
	exit 1
fi

# install brew packages
brew bundle --global

# install node/npm
# TODO: version指定できるように
nodebrew setup
nodebrew install v18
nodebrew use v18