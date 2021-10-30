#!/usr/bin/env bash

copy_files_from_dir_to_dir() {
	local FROM=$(echo "$1" | sed 's/\//\\\//g')
	local TO=$(echo "$2" | sed 's/\//\\\//g')
	local CP_FLAG="$3"
	if [ -n "$CP_FLAG" ]; then
		CP_FLAG="$CP_FLAG "
	fi
	tput smso
	echo "Copying files from \`./$1\` to \`$2\`"
	tput rmso
	find "./$1/" -type f | sed -n '
	# save frompath
	h
	# convert to topath
	'"s/^\.\/${FROM}/${TO}/g;"'
	# hold space for new topath
	x
	# add topath line
	# now: frompath\ntopath
	G
	# if frompath and topath are equal, do not output anything (see -n)
	/^\(.*\)\n\1/b
	# escape special characters for the shell
	s/["$`\\]/\\&/g
	# transform frompath\ntopath, to print:
	# - mkdir -p todir
	# - cp frompath topath
	s/^\(.*\)\n\(.*\)\(\/.*\)$/mkdir -p "\2"; cp '"${CP_FLAG}"'"\1" "\2\3"/p
	' | bash
}

copy_files_from_dir_to_dir home "$HOME"
copy_files_from_dir_to_dir conditional/home "$HOME" --no-clobber

tput smso
echo "Installing neovim plugins"
tput rmso
nvim --headless +PlugInstall +qa
