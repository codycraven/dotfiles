#!/usr/bin/env bash

copy_files_from_dir_to_dir() {
	local FROM="$1"
	local TO=$(echo "$2" | sed 's/\//\\\//g')
	tput smso
	echo "Copying files from \`./$FROM\` to \`$2\`"
	tput rmso
	find "./$FROM/" -type f | sed -n '
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
	s/^\(.*\)\n\(.*\)\(\/.*\)$/mkdir -p "\2"; cp "\1" "\2\3"/p
	' | bash 
}

copy_files_from_dir_to_dir home "$HOME"
