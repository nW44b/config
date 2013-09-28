# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#### 1.0 by nW44b #######################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Affiche cowsay et fortune
# Il faut installer cowsay et fortune-fr
#cowsay -f head-in.cow "`fortune -s`"

# Ajout de PATH
# PATH=$PATH:/home/benwa-ktm/.E-Finance\ Java/
PATH=$PATH:/usr/games/

########################################
# HISTORIQUE #
########################################

# Liste de commandes qui seront exclues : 
HISTIGNORE="ls:cd:ll:exit"

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Horodatage
HISTTIMEFORMAT="%D %H %M"

# Meilleure gestion de la recherche
# Par défaut, toutes les commandes tapées dans un terminal sont enregistrées 
# dans l'historique (fléches « haut » et « bas »). La façon dont vous 
# parcourez l'historique peut être améliorée de façon à ce que si vous tapez 
# un début de commande avant votre recherche, vous puissiez accéder uniquement 
# aux entrées commençant par ce que vous venez de taper. 
#PROMPT_COMMAND='history -a'
PROMPT_COMMAND='history -a;echo -en "\033[m\033[38;5;2m"$(( `sed -nu "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -nu "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;55m$(< /proc/loadavg)\033[m"'

########################################
# OTHERS #
########################################

# empèche l'écrasement lors d'une redirection (> ou >>). Demande la confirmation.
set -o noclobber

# Editeur par défaut.
export EDITOR=vim

# Vérifie la taille de la fenêtre après chaque commande,
# et met à jour les valeurs LINES et COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

########################################
# LA COULEUR DU PROMPT #
########################################

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
#    PS1='\[\033[00;31m\]\t ${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;31m\]@\[\033[01;33m\]\h\[\033[01;32m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='${debian_chroot:+($debian_chroot)}\[\e[m\e[1;30m\] -- \t \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

###############################################
# COULEURS #
###############################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
 
    export LS_OPTIONS='--color=auto'
 
    alias ls='ls -lh $LS_OPTIONS'
    alias dir='dir $LS_OPTIONS'
    alias vdir='vdir $LS_OPTIONS'
 
    alias grep='grep $LS_OPTIONSo'
    alias fgrep='fgrep $LS_OPTIONS'
    alias egrep='egrep $LS_OPTIONS'
fi

###############################################
# BASH ALIASES #
###############################################

# Pour importer le fichier .bash_aliases :
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias ll='ls -alFh'
alias la='ls -A'
#alias ls='ls -al'
alias cd..='cd ..'
alias df='df -aH'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias rmdelamort='shred -z -u -n 7 -v'
alias tarx='tar xvfz'
alias vi='vim'
alias fullupgrade='apt-get update ; apt-get upgrade -y && apt-get dist-upgrade -y && apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y'
alias mtr='mtr --curse'
alias pingg='ping google.com'
alias killswap='swapoff -a && swapon -a'
alias psuser='ps aux  --sort=-%cpu | grep -m 11 -v `whoami`'
alias lslastfiles='ls -altrh --time-style=+%D | grep `date +%D`'
#alias wrongpass='WHINY_USERS=1 awk '/Failed password for invalid user/{_[$11]++}END{for (i in _){printf "%s%s (%s)" ,sep,i,_[i];sep=", "};printf "\n"}' /var/log/auth.log'

# PERSO
alias sshks='ssh benwa-ktm@91.121.104.217 -p 2024'
alias sshr2='ssh benwa-ktm@r2dd2.org -p2024'

# DP
alias sshpinguin='ssh benwa-ktm@cnova.dyndns.org -p 2024'
alias sshnova='ssh benwa-ktm@cnova.dyndns.org -p 2024'
alias sshsamourai='ssh benwa-ktm@hacktic.dyndns.org'
alias sshvacarme='ssh benwa-ktm@vacarme.domainepublic.net -p3265'
alias sshlucie='ssh benwa-ktm@lucie.domainepublic.net -p3265'
alias sshginger='ssh benwa-ktm@ginger.domainepublic.net -p3265'

# GESTPUB
alias sshgestpub_puppetmaster='ssh root@87.98.187.68 -p2424'
alias sshgestpub_arthur='ssh root@178.32.100.92 -p22'
#alias sshgestpub_relay='ssh root@91.121.202.207 -p22'
alias sshgestpub_relay='ssh root@94.23.167.16 -p22'
alias sshgestpub_ns369325='ssh root@94.23.43.193 -p2424'
alias sshgestpub_ns389263='ssh root@176.31.101.54 -p2424'

# NIMAG
alias sshnimagipplan='ssh root@ipplan.nimag.net'
alias sshnimagisptest='ssh root@isptest1.nimag.net'
alias sshnimagadmin='ssh root@admin.nimag.net'
alias sshnimagispdb='ssh root@ispdb1.nimag.net'
alias sshnimagispmail1='ssh root@ispmail1.nimag.net'
alias sshnimagispweb1='ssh root@ispweb1.nimag.net'
alias sshnimagplesk='ssh root@plesk9.nimag.net'


###############################################
# LINUX LOGO #
###############################################

#linuxlogo

###############################################
# ALERTE #
###############################################

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# Nécessite le paquet libnotify-bin
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


###############################################
# COMPLETION #
###############################################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

