# If not running interactively, don't do anything beyond this.
case $- in
	*i*) ;;
	*) return ;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
else
	color_prompt=
fi

PS1='\$ '

# Load colors (aliases in .bash_aliases)
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Load aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Enable completions (comment out if already included in /etc/bash.bashrc /etc/profile)
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
