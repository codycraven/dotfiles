#!/usr/bin/env sh

RAN_UPDATE=0

apt_update() {
	if [ $RAN_UPDATE -eq 0 ]; then
		msg "Updating package information"
		sudo apt update
	fi
	RAN_UPDATE=1
}

apt_install() {
	apt_update
	msg "Installing missing $1 from apt"
	sudo apt install "$1" -y
}

snap_install() {
	msg "Installing missing $1 from snap"
	sudo snap install "$1" --classic
}

pip_install() {
	msg "Installing missing $1 from pip"
	pip install --user "$1"
}

msg() {
	tput smso
	echo "$1"
	tput rmso
}

has() {
	command -v $1 >/dev/null
}

has curl || apt_install curl
has git || apt_install git
has node || snap_install node
has nvim || apt_install neovim

pip list | grep pynvim -q || pip_install pynvim

