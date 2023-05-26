# Do everything.
all: init brew mac link

# install packages
init:
	sh scripts/init.sh

# bundle brew applications
brew:
	sh scripts/brew.sh

# setup macOS preferences
mac:
	sh scripts/mac.sh

# create symbolic links in $HOME
links:
	sh scripts/symlinks.sh
