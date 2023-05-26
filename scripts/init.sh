#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS"
	exit 1
fi

# Set zsh
chsh -s /bin/zsh

# Install Homebrew
which -s brew
if [[ $? != 0 ]] ; then
	/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null
else
    brew update
fi