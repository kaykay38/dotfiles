#-----------------------------------------------------
# .zshrc
# Author: kaykay38
# Last Modified: Dec 25, 2021
#-----------------------------------------------------

#-------------------------------------------
# ENV VARIABLES 
#-------------------------------------------
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:/usr/local/opt/texinfo/bin" # or follow the instructions given by brew info
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/share/python"
export PATH="$PATH:/usr/local/opt/ruby/bin"
export PATH="$PATH:$HOME/Scripts:$HOME/node_modules/.bin:$HOME/.local/bin"
export PATH="$PATH:$HOME/.config/nvim/utils/bin"
[[ $(uname) = Linux ]] || eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
# Preferred editor for local and remote sessions
export EDITOR='lvim'
export VISUAL='code'
export ONEDRIVE="$HOME/OneDrive"
export TODODIR="$ONEDRIVE/TODO"
export BAT_THEME="gruvbox-dark"

export JAR=$HOME/.config/jdtls/jdt-language-server-0.71.0-202104141151/plugins/org.eclipse.equinox.launcher_1.6.0.v20200915-1508.jar
export GRADLE_HOME=/usr/local/Cellar/gradle/7.0
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home
export JDTLS_CONFIG=$HOME/.config/jdtls/jdt-language-server-0.71.0-202104141151/config_mac
export WORKSPACE="$ONEDRIVE/CodeWorkspace/Java"
#
DOTNET_CLI_TELEMETRY_OPTOUT=1
#export PATH="$PATH:/home/mia/.dotnet/tools"
export DOTNET_ROOT=/usr/share/dotnet
export DOOMDIR=$HOME/.config/doom
export CHROME_EXECUTABLE='/Applications/Brave Browser.app/Contents/MacOS/Brave Browser'
export HOMEBREW_NO_AUTO_UPDATE=1
#-----------------------------------------------------
# NNN CONFIG 
#-----------------------------------------------------
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG="f:finder;o:fzopen;p:preview-tui;d:diffs;t:preview-tabbed;i:imgview" 
export NNN_FCOLORS="00001e318f00000000000000"
export NNN_BMS="g:$ONEDRIVE/CodeWorkspace/Github;j:$ONEDRIVE/CodeWorkspace/Java;c:$ONEDRIVE/CodeWorkspace/C;n:$ONEDRIVE/CodeWorkspace/NET;C:$HOME/.config;v:$HOME/.config/nvim;p:$HOME/Pictures;d:$HOME/Downloads"

#-------------------------------------------
# HISTORY
#-------------------------------------------
# History configurations
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

#-------------------------------------------
# COLORS
#-------------------------------------------
if [ -f $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[path]=underline
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
fi

#-------------------------------------------
# COMPLETION & MISC.
#-------------------------------------------
setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word
# TAB COMPLETION 
autoload -Uz compinit && compinit
compinit -d $HOME/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion
zstyle ':completion:*' menu yes select
    # Take advantage of $LS_COLORS for completion as well
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:ls:*' menu yes select
zstyle ':completion:*:processes' command 'ps -U $(whoami)|sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'ps xho command|sed "s/://g"'
zstyle ':completion:*:processes' sort false 

#-----------------------------------------------------
# PLUGINS
#-----------------------------------------------------
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/websearch.zsh
source $HOME/.config/zsh/find.zsh
source $HOME/.config/lf/icons.sh
source $HOME/.config/zsh/lfcd.sh

#-----------------------------------------------------
# ALIASES 
#-----------------------------------------------------
alias ..="cd .."
alias s="sudo"
alias grep="grep --color"
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias rm="trash"
alias dwn="cd ~/Downloads"
alias l="exa --icons"
alias la="exa -a --icons"
alias ll="exa -al --icons"
alias ls="ls -Ga"
alias lsl="ls -Gal"
alias g="git"
alias gcl=gitclone
alias lf=lfcd
alias srr="sudo ranger"
alias nn="nnn -eUH"
alias v="lvim"
alias vs="open -a Visual\ Studio.app"
alias zrc="lvim $HOME/.zshrc"
alias src="source $HOME/.zshrc"
alias vd="cd $HOME/.config/lvim"
alias vrc="lvim $HOME/.config/lvim/config.lua"
alias conf="cd $HOME/.config"
alias codes="cd $ONEDRIVE/CodeWorkspace"
alias scripts="cd $HOME/Scripts"
alias dgit="cd $ONEDRIVE/CodeWorkspace/Github"
alias dpy="cd $ONEDRIVE/CodeWorkspace/Python"
alias djava="cd $ONEDRIVE/CodeWorkspace/Java"
alias dc="cd $ONEDRIVE/CodeWorkspace/C"
alias dnet="cd $ONEDRIVE/CodeWorkspace/NET"
alias oned="cd $ONEDRIVE"
alias ctext="cd $ONEDRIVE/CurrTextbooks"
alias dotfiles="open https://github.com/kaykay38/dotfiles"
alias gmail="open https://mail.google.com/mail/u/1/#inbox"
alias canvas="open https://canvas.ewu.edu/"
alias ccal="open https://canvas.ewu.edu/calendar"
alias eagnet="open https://eaglenet.ewu.edu/"
alias sling="open https://app.getsling.com/ 2>/dev/null"
alias chegg="open https://www.chegg.com/"

function za() { zathura "$1" & disown %zathura }

function git_update {
    GIT_DISCOVERY_ACROSS_FILESYSTEM=true
    git_status="$(git -C "$1" rev-parse 2>/dev/null)"; if [ $? -eq 0 ]; then 
        echo "$1"
        echo "git: fetching from remote"
        st="$(rg 'Your branch is up to date' <<< $(git status $1 2>/dev/null))"
        if [[ "$st" ]]; then
            echo $st
        else
            git fetch 1>/dev/null && git pull || echo -c "\033[0;31mgit: failed to pull from remote\033[0m"
        fi
    fi
}

function fzd {
    dir="$(fd -H -t d -c never -d 3 | fzf)"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

function fzh() {
    dir="$(fd -t d -c never --base-directory $HOME --ignore-file "$HOME/.config/fd/.ignore" --search-path $HOME 2>/dev/null | fzf)"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

function fzg() {
    dir="$(fd -c never -t d -H --ignore-file "$HOME/.config/fd/ignore-git-home" '^\.git$' --search-path $HOME 2>/dev/null | sed s#.git## | fzf --prompt='Jump to git repo > ')"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

# # ex - archive extractor
# # usage: ex <file>
function ex()
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
# KEY BINDINGS
#-------------------------------------------
# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action
bindkey -s '^f' 'fzh\n'
bindkey -s '^o' 'fzd\n'
bindkey -s '^g' 'fzg\n'

#-------------------------------------------
# PROMPT
#-------------------------------------------
#source $HOME/.p10k.zsh
#source $HOME/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
# autoload -U zmv
# setopt extended_glob
# Load version control
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# zstyle ':vcs_info:git*' formats "   %b"
# setopt prompt_subst
#   
# Current time & time elapsed between last command
# PROMPT=' %F{blue}%f %F{209}%3~%f%F{106}${vcs_info_msg_0_}%f %(?.%F{71}❯.%F{red}❯)%f '
eval "$(starship init zsh)"
RPROMPT='%F{blue} %D{%L:%M:%S %p}%f'
