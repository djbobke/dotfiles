# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth

# disable ctrl+s
stty ixoff -ixon

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
else
	color_prompt=
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Bashmarks
if [ -f ~/.bashmarks ]; then
    . ~/.bashmarks
fi

pidwait() {
	while [[ ( -d /proc/$1 ) && ( -z `grep zombie /proc/$1/status` ) ]]; do
		sleep 1
	done
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
export PS1="\[\e[0;32m\]\u\[\e[m\]@\[\e[0;31m\]\h \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0m\]"
export PATH=~/bin:$PATH

# Add sbin to $PATH since some OS-es dont do this by default
export PATH=$PATH:/sbin:/usr/sbin
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
export SVN_EDITOR=nano
export EDITOR=nano

function cake {
	if [ -d "Console" ]; then
		sudo -u www-data ./Console/cake $@
	else
		echo "Not a CakePHP tree"
	fi
}
