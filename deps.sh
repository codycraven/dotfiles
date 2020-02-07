#!/usr/bin/env sh

RAN_UPDATE=0

update() {
	if [ $RAN_UPDATE -eq 0 ]; then
		tput smso
		echo "Updating package information"
		tput rmso
		sudo apt update
	fi
	RAN_UPDATE=1
}

check_app() {
	if ! command -v $1 >/dev/null; then
		update
		tput smso
		echo "Installing missing $2"
		tput rmso
		sudo apt install "$2" -y
	fi
}

check_app curl curl
check_app git git
check_app nvim neovim

