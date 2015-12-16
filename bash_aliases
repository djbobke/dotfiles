if [ `uname -s | grep -i Linux` ]; then
	alias ls='ls --color=auto'
fi

alias grep='grep --color=auto --exclude-dir=".svn"'
alias fgrep='fgrep --color=auto --exclude-dir=".svn"'
alias egrep='egrep --color=auto --exclude-dir=".svn"'

alias ll='ls -l'
alias la='ls -A'

alias diffpatch='diff -urpN --exclude=CVS --exclude=*~ --exclude=defconfig --exclude=.svn --exclude=.git --exclude=.repo'
alias hd='hexdump -C'
alias fgc='find -regex ".*\.\(c\|mk\|java\|h\|ctp\|cpp\|php\|S\)$" -print0 | xargs -0 grep --color=auto '

alias ..='cd ..'
alias ...='cd ../../'
alias htop='env LANG=C htop'
alias generate_poedit='cake i18n extract --overwrite --extract-core=no --merge=no --exclude $(pwd)/webroot/pma --output $(pwd)/Locale --paths $(pwd)/'

alias 'apt-search=aptitude search'
alias 'acs=apt-cache search'
alias 'aw=apt-cache show'

alias 'tm=tmux -2'
alias 'tma=tmux -2 attach'
