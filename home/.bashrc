# If not running interactively, don't do anything beyond this.
case $- in
	*i*) ;;
	*) return ;;
esac

export EDITOR='nvim'

has_color=$(command -v tput > /dev/null && tput setaf 1 >&/dev/null && echo 1 || echo 0)
has_git=$(command -v git > /dev/null && echo 1 || echo 0)
has_helm=$(command -v helm > /dev/null && echo 1 || echo 0)
has_kubectl=$(command -v kubectl > /dev/null && echo 1 || echo 0)

if [ $has_kubectl -eq 1 ]; then
	source <(kubectl completion bash)
fi
if [ $has_helm -eq 1 ]; then
	source <(helm completion bash)
fi

function prompt_cmd {
	local EXIT="$?"
	if [ $has_color -eq 1 ]; then
		if [ $EXIT -ne 0 ]; then
			tput setaf 1
			tput bold
			echo -n "$EXIT "
			tput sgr0
		fi
		if [ $has_kubectl -eq 1 ]; then
			tput setaf 4
			echo -n "⎈ "
			tput setaf 6
			echo -n "$(kubectl config current-context 2> /dev/null || echo "no context")  "
		fi
		if [ $has_git -eq 1 ]; then
			tput setaf 2
			echo -n "⑂ "
			tput setaf 3
			echo -n "$(git branch --show-current 2> /dev/null || echo "no repo")  "
		fi
		tput sgr0
		tput setaf 5
		echo ""
		pwd
		tput sgr0
	else
		if [ $EXIT -ne 0 ]; then
			echo -n "$EXIT "
		fi
		if [ $has_kubectl -eq 1 ]; then
			echo -n "⎈ $(kubectl config current-context 2> /dev/null || echo "no context")  "
		fi
		if [ $has_git -eq 1 ]; then
			echo -n "⑂ $(git branch --show-current 2> /dev/null || echo "no repo")  "
		fi
		echo ""
		pwd
	fi
}
PROMPT_COMMAND=prompt_cmd

# See .inputrc for the string
PS1=' '

# Vim editor
set -o vi

# History settings
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Resize window after command
shopt -s checkwinsize

# Support globbing
shopt -s globstar

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
