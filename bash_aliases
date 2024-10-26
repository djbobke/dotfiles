if [ `uname -s | grep -i Linux` ]; then
	alias ls='ls --color=auto'
fi

alias grep='grep --color=auto'

alias ll='ls -l'
alias la='ls -A'

alias hd='hexdump -C'

alias ..='cd ..'
alias ...='cd ../../'
alias htop='env LANG=C htop'

alias 'apt-search=aptitude search'
alias 'acs=apt-cache search'
alias 'aw=apt-cache show'

alias 'tm=tmux -2'
alias 'tma=tmux -2 attach'
