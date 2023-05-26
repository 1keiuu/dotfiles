# Do everything.
all:echo $SHELL
	init symlinks brew mac

# install packages
init:
	sh scripts/init.sh

# bundle brew applications
dump-brew:
	sh scripts/dump-brew.sh

# install applications listed in .Brewfile
sync-brew:
	sh scripts/sync-brew.sh

# setup macOS preferences
mac:
	sh scripts/mac.sh

# create symbolic links in $HOME
symlinks:
	sh scripts/symlinks.sh
