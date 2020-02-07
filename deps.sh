#!/usr/bin/env sh

RAN_UPDATE=0

apt_update() {
	if [ $RAN_UPDATE -eq 0 ]; then
		tput smso
		echo "Updating package information"
		tput rmso
		sudo apt update
	fi
	RAN_UPDATE=1
}

apt_install() {
	apt_update
	tput smso
	echo "Installing missing $2"
	tput rmso
	sudo apt install "$1" -y
}

snap_install() {
	sudo snap install "$1" --classic
}

has() {
	command -v $1 >/dev/null
}

has curl || apt_install curl
has git || apt_install git
has node || snap_install node
has nvim || apt_install neovim

