# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth

export HISTTIMEFORMAT='%F %T '  # Adds date and time to each command in history.
export HISTSIZE=10000           # Store a larger command history.
export HISTFILESIZE=20000       # Allow larger history files.

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

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

[ -x /usr/bin/dircolors ] && eval `dircolors -b $HOME/.dircolors`

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Bashmarks
if [ -f ~/.bashmarks ]; then
    . ~/.bashmarks
fi

export TERM=${TERM:-xterm-256color}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export GIT_BRANCH='$(git rev-parse --abbrev-ref HEAD 2>/dev/null)'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PS1="\[\e[1;36m\]\u@\[\e[1;36m\]\h \[\e[1;97m\]\w\[\e[m\] \[\e[1;33m\]$GIT_BRANCH\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[0m\]"
export PATH=~/bin:./vendor/bin:$PATH
export GOPATH=$HOME
export GOBIN=$HOME/bin
# Add sbin to $PATH since some OS-es dont do this by default
export PATH=$PATH:/sbin:/usr/sbin:/usr/local/go/bin
export CDPATH=.:$HOME
export PROMPT_COMMAND='pwd > ~/.last_dir; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/\~}\007"'
export EDITOR=nano

export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline

pidwait() {
	while [[ ( -d /proc/$1 ) && ( -z `grep zombie /proc/$1/status` ) ]]; do
		sleep 1
	done
}

function ta()
{
	tmux -2 attach -t$1
	if (($? > 0)); then
		tmux -2
	fi
}
tmux_sessions=$(tmux ls 2> /dev/null | cut -d : -f 1)
complete -W "$tmux_sessions" ta

function ssh-copy-id()
{
	if [ ! -e ~/.ssh/id_rsa.pub ]; then
		printf "You have no key to copy... \e[1;31m-_-\e[0;36m'\e[0m\n"
		return 1
	fi

	cat ~/.ssh/id_rsa.pub | ssh $@ "mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"
}

#
# Remember last directory
#
if [ -f ~/.last_dir ]; then
	LAST_DIR=`cat ~/.last_dir`
	if [[ -d "${LAST_DIR}" && "$VSCODE_PID" == "" ]]; then
		if [[ "$TERM_PROGRAM" != "vscode" ]]; then
			builtin cd `cat ~/.last_dir`
		fi
	fi
fi

#
# Import local overrides
#
if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
