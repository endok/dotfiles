#-- path --#
export PATH=$HOME/bin:/opt/local/bin:/usr/local/bin:/usr/X11/bin:/usr/bin:/bin:/opt/local/sbin:/usr/local/sbin:/usr/sbin:/sbin

#-- completion --#
autoload -U compinit
compinit
zstyle ':completion:*' list-colors di='01;33' ln='01;32' ex='01;31'
setopt auto_pushd
setopt list_packed
unsetopt list_ambiguous
setopt nolistbeep
setopt complete_in_word
setopt auto_menu
setopt list_rows_first
#zstyle ':completion:*:default' menu select=1
LISTMAX=10000

#-- prompt --#
autoload colors
colors
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

case "${TERM}" in
kterm* | xterm* | screen)
PROMPT="%{${fg[cyan]}%}<%m>%{${reset_color}%} "
RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%} "
if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] ; then
PROMPT="%{${fg[magenta]}%}<%m>%{${reset_color}%} "
RPROMPT="%{${fg[magenta]}%}[%~]%{${reset_color}%} "
fi
# PROMPT="%{${fg[cyan]}%}%m[%~]%#%{${reset_color}%} "
# [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
# PROMPT="%{${fg[magenta]}%}%m[%~]%#%{${reset_color}%} "
;;
* )
PROMPT="%m[%~]%# "
esac

#-- screen --#
# コマンド実行中はコマンド名、それ以外はカレントディレクトリ
#if [ ${TERM} = "screen" -a -z "${REMOTEHOST}${SSH_CONNECTION}" ]; then
    #preexec() {
        #echo -ne "\ek*${1%% *}\e\\"
    #}
    #precmd() {
        #echo -ne "\ek$(basename $(print -P "%~"))\e\\"
    #}
#fi
#if [ ${TERM} = "screen" -a -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
    #preexec() {
        #echo -ne "\ek$(hostname -s):*${1%% *}\e\\"
    #}
    #precmd() {
        #echo -ne "\ek$(hostname -s):$(basename $(print -P "%~"))\e\\"
    #}
#fi

#function ssh_screen(){
	#eval server=\${$#}
	#screen -t $server ssh "$@"
#}
#if [ $TERM = "screen" ]; then
	#alias ssh=ssh_screen
#fi

#-- terminal title --#
# case "${TERM}" in
# kterm*|xterm)
#   precmd() {
#     echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#     }
#     ;;
# esac

#-- history --#
HISTFILE=~/.zsh/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
#setopt share_history

#-- keybind --#
bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
stty stop undef

#-- alias --#
#alias su='su -l'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'
alias ..='cd ..'
alias xterm='xterm -bg black -fg white -fn 7x13'
alias kterm='kterm -km euc'
alias vizsh='vi $HOME/.zsh/.zshrc'
alias sourcezsh='source $HOME/.zsh/.zshrc'
alias -g L='| less'
alias -g G='| grep'

if [ `uname` = Linux ]; then; alias ls='ls --color=auto'; fi
if [ `uname` = Darwin ]; then; alias top='top -o cpu'; fi

if [ `uname` = FreeBSD -o `uname` = Darwin ]; then 
  alias ls='ls -hG'
  export LSCOLORS=DxCxdxgxBxegedabagacad
fi

limit coredumpsize 0

#-- set other options --#
setopt no_hup
setopt no_check_jobs
setopt notify
setopt auto_cd

#-- source local file --#
if [ -e $ZDOTDIR/.zshrc.local ]; then; source $ZDOTDIR/.zshrc.local; fi

