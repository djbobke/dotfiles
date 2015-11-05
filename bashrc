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

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

[ -x /usr/bin/dircolors ] && eval `dircolors -b $HOME/.dircolors`

function cd {
    builtin cd $@
    pwd > ~/.last_dir
}

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Bashmarks
if [ -f ~/.bashmarks ]; then
    . ~/.bashmarks
fi

if [ -e /usr/share/terminfo/r/rxvt-256color ]; then
        export TERM='rxvt-256color'
else
        export TERM='xterm-color'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export GIT_BRANCH='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\\\\\1\ /`'
export PS1="\[\e[1;36m\]\u@\[\e[1;36m\]\h \[\e[1;97m\]\w\[\e[m\] \[\e[1;33m\]$GIT_BRANCH\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[0m\]"
export PATH=~/bin:$PATH

# Add sbin to $PATH since some OS-es dont do this by default
export PATH=$PATH:/sbin:/usr/sbin
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/\~}\007"'
export EDITOR=nano

export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline

# TMUX-git
if [ -f ~/.tmux-git ]; then
    . ~/.tmux-git
fi

pidwait() {
	while [[ ( -d /proc/$1 ) && ( -z `grep zombie /proc/$1/status` ) ]]; do
		sleep 1
	done
}

function cake {
	if [ -d "../Vendor/bin" ]; then
		sudo -u www-data ../Vendor/bin/cake $@
	elif [ -d "Console" ]; then
		sudo -u www-data ./Console/cake $@
	elif [ -d "app/Console" ]; then
		cd app
		sudo -u www-data ./Console/cake $@
		cd ..
	else
		echo "Not a CakePHP tree"
	fi
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

function log()
{
	LOGDIR="$HOME/log"
	LOGFILE=$(date +%Y%m%d_%H%M%S)
	mkdir -p $LOGDIR
	echo "Logging to $LOGDIR/$LOGFILE"
	echo "Executing $1" > $LOGDIR/$LOGFILE
	$1 | awk '{ print d,$0}' "d=[$(date "+%F %T")]" | tee $LOGDIR/$LOGFILE
}

if [ -f ~/.last_dir ]; then
	cd `cat ~/.last_dir`
fi

if [ -f ~/.bashrc_local ]; then
	. ~/.bashrc_local
fi
