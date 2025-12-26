#-----------------------------------------------------
# .zshrc
# Author: kaykay38
# Last Modified: May 07, 2025
#-----------------------------------------------------

#-------------------------------------------
# ENV VARIABLES 
#-------------------------------------------
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:/usr/local/opt/texinfo/bin" # or follow the instructions given by brew info
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/share/python"
export PATH="$PATH:/usr/local/opt/ruby/bin"
export PATH="$PATH:$HOME/node_modules/.bin:$HOME/.local/bin:$HOME/Library/Python/3.9/bin"
export PATH="$PATH:$HOME/.config/nvim/utils/bin"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH=
export OS=$(uname)
[[ $OS = Linux ]] || eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# Preferred editor for local and remote sessions
export EDITOR='lvim'
export VISUAL='codium'
export SYNCDRIVE="$HOME/Documents"
export TODODIR="$SYNCDRIVE/TODO"
export BAT_THEME="gruvbox-dark"
# export TERM=xterm-256color

DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT=/usr/share/dotnet
# export DOOMDIR=$HOME/.config/doom
[[ $OS = Darwin ]] && export CHROME_EXECUTABLE='/Applications/Firefox.app/Contents/MacOS/firefox'
export HOMEBREW_NO_AUTO_UPDATE=1
export CARGO_NET_GIT_FETCH_WITH_CLI=true

#-------------------------------------------
# HISTORY
#-------------------------------------------
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
# source $HOME/.config/lf/icons.sh
# source $HOME/.config/zsh/lfcd.sh

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
alias ls="ls -a --color"
alias lsl="ls -al --color"
alias g="git"
alias gcl=gitclone
alias lf=yazi
alias srr="sudo ranger"
alias v="lvim"
alias vs="open -a Visual\ Studio.app"
alias zrc="lvim $HOME/.zshrc"
alias src="source $HOME/.zshrc"
alias vd="cd $HOME/.config/lvim"
alias vrc="lvim $HOME/.config/lvim/config.lua"
alias conf="cd $HOME/.config"
alias codes="cd $SYNCDRIVE/CodeWorkspace"
alias proj="cd $SYNCDRIVE/CodeWorkspace/Swift/AHDI\ Assistant"
alias career="cd $SYNCDRIVE/Career/"
alias scripts="cd $HOME/Scripts"
alias dgit="cd $SYNCDRIVE/CodeWorkspace/Github"
alias dpy="cd $SYNCDRIVE/CodeWorkspace/Python"
alias djava="cd $SYNCDRIVE/CodeWorkspace/Java"
alias dc="cd $SYNCDRIVE/CodeWorkspace/C"
alias dnet="cd $SYNCDRIVE/CodeWorkspace/NET"
alias ctext="cd $SYNCDRIVE/CurrTextbooks"
alias gmail="open https://mail.google.com/mail/u/1/#inbox"
alias tf="terraform"
[[ -f $HOME/.aliases.zsh ]] && source $HOME/.aliases.zsh
if [[ $OS = Linux ]]; then
    alias open=open-disown "$1"
    alias awmd="cd $HOME/.config/awesome"
    alias awmc="cd $HOME/.config/awesome && $EDITOR $HOME/.config/awesome/rc.lua"
    alias dwmd="cd $HOME/Suckless/dwm"
    alias dwmc="cd $HOME/Suckless/dwm && $EDITOR $HOME/Suckless/dwm/config.def.h"
fi

#-----------------------------------------------------
# FUNCTIONS 
#-----------------------------------------------------
function open-disown() {
    xdg-open "$1" & disown '%xdg-open' 
}

function za() {
    case $OS in
        Darwin) /Applications/sioyek.app/Contents/MacOS/sioyek "$1" & disown %/Applications/sioyek.app/Contents/MacOS/sioyek ;;
        *) zathura "$1" & disown %zathura ;; 
    esac
}

function git_update() {
    git_status="$(git -C . rev-parse 2>/dev/null)"; if [ $? -eq 0 ]; then 
        echo "cd -> $1"
        git fetch 1>/dev/null
        st="$(rg 'Your branch is up to date' <<< $(git status 2>/dev/null))"
        [[ "$st" ]] || echo "git: pulling from remote" && git pull || echo "\033[0;31mgit: failed to pull from remote\033[0m"
    fi
}

function fzq() {
    dir="$(fd -t d -c never -L --ignore-file "$HOME/.config/fd/ignore-home" --search-path $SYNCDRIVE/2021-22Q3Spring 2>/dev/null | fzf --prompt='Jump to > ')"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

function fzh() {
    dir="$(fd -t d -c never --base-directory $HOME --ignore-file "$HOME/.config/fd/ignore-home" --search-path $HOME 2>/dev/null | fzf --prompt='Jump to > ' )"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

function fzd() {
    dir="$(fd -H -t d -c never -d 3 | fzf --prompt='Jump to > ' | sed -e "1 s#.#$(pwd)#")"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

function fzo() {
    file="$(fd -H -c never -d 3 | fzf --prompt='Open > ')"
    if [[ "$file" ]]; then
        case $(file --mime-type "$file" -bL) in
            application/pdf) za "$file" ;;
            text/html) open "$file" || xdg-open "$file"& ;;
            text/*|application/json) $EDITOR "$file" ;;
            *) open "$file" || xdg-open "$file"& ;;
        esac
    fi
}

function fzg() {
    dir="$(fd -c never -t d -H --ignore-file "$HOME/.config/fd/ignore-git-home" '\.git' --search-path $HOME 2>/dev/null | sed -e 's#/\.git##'  | fzf --prompt='Jump to git repo > ')"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

function dotfiles() {
    cd $HOME/.config/.dotfiles && git_update $HOME/.config/.dotfiles
}

# # ex - archive extractor
# # usage: ex <file>
function ex() {
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
bindkey -s '^h' 'fzh\n'
bindkey -s '^o' 'fzo\n'
bindkey -s '^l' 'fzd\n'
bindkey -s '^g' 'fzg\n'
bindkey -s '^v' 'fzq\n'

#-------------------------------------------
# PROMPT
#-------------------------------------------
if [[ $OS = Darwin ]]; then
    NEWLINE=$'\n'
    # PROMPT='${NEWLINE}%F{blue}%f %F{209}%3~%f%F{106}${vcs_info_msg_0_}%f${NEWLINE}%(?.%F{71}❯.%F{red}❯)%f '
    PROMPT='${NEWLINE}%F{209}%3~%f%F{106}${vcs_info_msg_0_}%f${NEWLINE}%(?.%F{71}❯.%F{red}❯)%f '
    autoload -U zmv
    setopt extended_glob
    # START Load version control
    autoload -Uz vcs_info
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    zstyle ':vcs_info:git*' formats "   %b"
    setopt prompt_subst
    # END Load version control
    #   
else
    eval "$(starship init zsh)"
fi
RPROMPT='%F{blue} %D{%L:%M:%S %p}%f'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# Added by Windsurf
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="/Users/miaxyhunt/.codeium/windsurf/bin:$PATH"
