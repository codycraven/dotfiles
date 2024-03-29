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

pip3_install() {
	msg "Installing missing $1 from pip3"
	pip3 install --user "$1"
}

msg() {
	tput smso
	echo "$1"
	tput rmso
}

has_cmd() {
	command -v $1 >/dev/null
}

has_pkg() {
	dpkg -s "$1" >/dev/null 2>&1
}

has_pip3() {
	pip3 list | grep "$1" >/dev/null
}

has_cmd curl || apt_install curl
has_cmd git || apt_install git
has_cmd pip3 || apt_install python3-pip
has_cmd nvim || apt_install neovim
has_pkg byobu || apt_install byobu
has_pkg inotify-tools || apt_install inotify-tools
has_pkg inotify-hookable || apt_install inotify-hookable
has_pkg keychain || apt_install keychain

# Required for Xresources conf
has_pkg libxft2 || apt_install libxft2
has_pkg ttf-dejavu || apt_install ttf-dejavu

# Required for Deoplete in Neovim
has_pip3 pynvim || pip3_install pynvim

