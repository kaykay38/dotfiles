#
# ~/.bashrc
#
[[ $- != *i* ]] && return
#-------------------------------------------
# PROMPT
#-------------------------------------------
#autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
# Format the vcs_inf_msg
#zstyle ':vcs_info:git:*' formats ' %b'
# Set up the prompt with git branch name on right side
#setopt prompt_subst
#RPROMPT='%F{30}${vcs_info_msg_0_}%f'
PROMPT='%(?.%F{green}✓.%F{red}?%?)%f %F{209}%1~%f %F{36}$%f '

#-------------------------------------------
# COLORS
#-------------------------------------------
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
#-------------------------------------------
# ENV VARIABLES 
#-------------------------------------------
export DOTNET_ROOT=/opt/dotnet
export PATH=$PATH:/opt/dotnet
# NNN CONFIG
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;t:preview-tabbed;i:imgview' 
#export NNN_FCOLORS='00001e318f00000000000000'
export NNN_BMS='c:$HOME/OneDrive/CodeWorkspace;j:$HOME/CodeWorkspace/Java'
export NNN_FIFO="/tmp/nnn.fifo"
#-------------------------------------------
# ALIASES
#-------------------------------------------
alias s="sudo"
alias l="exa -a --icons"
alias ll="exa -al --icons"
alias ls="ls -a --color"
alias lsl="ls -al --color"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias open="xdg-open"
alias v="nvim"
alias sv="sudo nvim"
alias g="git"
alias nn="nnn -eU"
alias brc="nvim $HOME/.bashrc"
alias zrc="nvim $HOME/.zshrc"
alias src="source $HOME/.bashrc"
alias vrc="nvim $HOME/.config/nvim/init.vim"
alias rr="ranger"
alias srr="sudo ranger"
alias dwn="cd $HOME/Downloads"
alias vd="cd $HOME/.config/nvim"
alias svd="cd /opt/nvim/share/nvim/runtime"
alias sub="subl"
alias pc="pcmanfm . &"
alias bar="killall -9 polybar & $HOME/.config/polybar/launch.sh"
alias barc="nvim $HOME/.config/polybar/config.ini"
alias cal='calcurse'
alias pulse="killall pulseaudio"
alias conf="cd $HOME/.config"
alias startup="cd $HOME/.config/.startup"
alias codes="cd $HOME/OneDrive/CodeWorkspace"
alias ctext="cd $HOME/OneDrive/CurrTextbooks"
alias ewu="cd $HOME/OneDrive/2020-21Q2Winter"
alias codes="cd $HOME/OneDrive/CodeWorkspace"
alias gitd="cd $HOME/OneDrive/CodeWorkspace/Github"
alias netd="cd $HOME/OneDrive/CodeWorkspace/NET"
alias cs240="cd $HOME/OneDrive/2020-21Q2Winter/CSCD240-CandUnix"
alias cs327="cd $HOME/OneDrive/2020-21Q2Winter/CSCD327-RelationalDatabases"
alias cs371="cd $HOME/OneDrive/CodeWorkspace/NET/CSCD371-NETProgramming"
alias ma301="cd $HOME/OneDrive/2020-21Q2Winter/MATH301-DiscreteMathematics"
alias 350proj="cd $HOME/OneDrive/CodeWorkspace/CS350Project"
alias dotfiles="xdg-open https://github.com/kaykay38/dotfiles &"
alias canvas="xdg-open https://canvas.ewu.edu/ &"
alias ccal="xdg-open https://canvas.ewu.edu/calendar#view_name=month&view_start= &"
alias c371g="xdg-open https://github.com/IntelliTect-Samples/EWU-CSCD371-2021-Winter &"
alias c240="xdg-open https://canvas.ewu.edu/courses/1427733 &"
alias c327="xdg-open https://canvas.ewu.edu/courses/1427835 &"
alias c371="xdg-open https://canvas.ewu.edu/courses/1451913 &"
alias m371b="zathura $HOME/OneDrive/CurrTextbooks/Essential\ C\ Sharp\ 8.0\ by\ Mark\ Michaelis.pdf&"
alias m301="xdg-open https://canvas.ewu.edu/courses/1427319 &"
alias m301b="zathura $HOME/OneDrive/CurrTextbooks/Discrete\ mathematics\ and\ its\ applications\ by\ Rosen,\ Kenneth.pdf &"
alias vpn="sudo $HOME/.config/.startup/ewuVPN.sh &"
