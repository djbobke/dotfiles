alias ls='ls --color=auto'

alias grep='grep --color=auto --exclude-dir=".svn"'
alias fgrep='fgrep --color=auto --exclude-dir=".svn"'
alias egrep='egrep --color=auto --exclude-dir=".svn"'

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias diffpatch='diff -urpN --exclude=CVS --exclude=*~ --exclude=defconfig --exclude=.svn --exclude=.git --exclude=.repo'
alias hd='hexdump -C'
alias fgc='find -regex ".*\.\(c\|mk\|java\|h\|cpp\|php\|S\)$" -print0 | xargs -0 grep '
