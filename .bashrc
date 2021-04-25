case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\] $PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
################

mac=$(cat /sys/class/net/*/address|sort|md5sum |cut -c1-6)
case $mac in
12387e)
  id2="9"
  ;;
658a17)
  id2="10"
  ;;
5ee45e)
  id2="11"
  ;;
1f7e3d)
  id2="12"
  ;;
cb8ba2)
  id2="13"
  ;;
b9e6f5)
  id2="14"
  ;;
6d3d39)
  id2="15"
  ;;
ea797f)
  id2="16"
  ;;
999bd5)
  id2="3"
  ;;
1f2bde)
  id2="4"
  ;;
8247d4)
  id2="5"
  ;;
03d404)
  id2="6"
  ;;
046a1b)
  id2="7"
  ;;
847ae5)
  id2="8"
  ;;
*)
  id2="???"
  ;;
esac

. /cute_main_param
export set EDITOR=vi
export HISTCONTROL="erasedups:ignoreboth"
PATH=./:/home/geko:/home/geko/remote:$PATH
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[01;34m\]\w\[\033[01;31m\]\[\033[00m\]\$ '
aa=$(ifconfig $(route -n | grep ^0.0.0.0 | awk '{print $NF}') | grep inet | grep -v inet6 | awk '{print $2}'|cut -f2 -d":")
PS1="$aa <$id2> ($mac) $PS1"

alias pss="/home/geko/remote/pss" 
alias b="/home/geko/b;echo \"grep warning..\";/home/geko/remote/bash.sh \"grep arning /tmp/cute*log\""
alias l="ls -ltr"
alias branch='git branch -a'
alias commit="git commit -m '.'"
alias push="git push"
alias valgrind='valgrind --leak-check=full --track-origins=yes'
alias clone='rm -fr cinnamon;git clone https://github.com/gekomad/cinnamon.git;cd cinnamon/src;branch'
alias commit='git commit -m '\''.'\'''
export AURIGA_ROOT=/home/geko/auriga_root
free|grep Mem
cat /etc/*release 2>/dev/null |grep VERSION=


