#-------------------------------------------
# PROMPT
#-------------------------------------------
source $HOME/.p10k.zsh
GITSTATUS_LOG_LEVEL=DEBUG
#-------------------------------------------
# ENV VARIABLES 
#-------------------------------------------
export PATH=$PATH:$HOME/dotnet:/home/mia/.dotnet/tools:$HOME/OneDrive/CodeWorkspace/Scripts:/home/mia/node_modules/.bin
# Add .NET Core SDK tools
#export PATH="$PATH:/home/mia/.dotnet/tools"
export DOTNET_ROOT=/usr/share/dotnet
# NNN CONFIG
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;t:preview-tabbed;i:imgview' 
export NNN_FCOLORS='00001e318f00000000000000'
export NNN_BMS='c:$HOME/OneDrive/CodeWorkspace;j:$HOME/CodeWorkspace/Java'
export NNN_FIFO="/tmp/nnn.fifo"
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
autoload -Uz compinit
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
#------------------------------------------
# PLUGINS & SCRIPTS
#-------------------------------------------
source $HOME/.config/zsh/find.zsh
source $HOME/.config/zsh/alacritty-win-title.zsh
source $HOME/.config/zsh/websearch.zsh
source $HOME/.config/zsh/zsh-autosuggestions
source $HOME/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
#-------------------------------------------
# ALIASES
#-------------------------------------------
alias s="sudo"
alias l="exa --icons"
alias la="exa -a --icons"
alias ll="exa -al --icons"
alias ls="ls --color"
alias lsl="ls -al --color"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias open="xdg-open"
alias pac="sudo pacman -S"
alias pacr="sudo pacman -Rs"
alias pacs=pacSearch
alias v="nvim"
alias sv="sudoedit"
alias za=zathuraOpen
alias g="git"
alias nn="nnn -eU"
alias zrc="nvim $HOME/.zshrc"
alias src="source $HOME/.zshrc"
alias vrc="nvim $HOME/.config/nvim/init.vim"
alias rr="ranger"
alias srr="sudo ranger"
alias pc="pcmanfm . &"
alias smake="sudo make clean install"
alias dwn="cd $HOME/Downloads"
alias pic="cd $HOME/Pictures"
alias scrshots="cd $HOME/Pictures/Screenshots"
alias vd="cd $HOME/.config/nvim"
alias svd="cd /opt/nvim/share/nvim/runtime"
alias conf="cd $HOME/.config"
alias sys="cd $HOME/.config/.system"
alias suckless="cd $HOME/Suckless"
alias dwmd="cd $HOME/Suckless/dwm"
alias dwmc="cd $HOME/Suckless/dwm && nvim $HOME/Suckless/dwm/config.h"
alias oned="cd $HOME/OneDrive"
alias ewu="cd $HOME/OneDrive/2020-21Q2Winter"
alias codes="cd $HOME/OneDrive/CodeWorkspace"
alias gitd="cd $HOME/OneDrive/CodeWorkspace/Github"
alias netd="cd $HOME/OneDrive/CodeWorkspace/NET"
alias javad="cd $HOME/OneDrive/CodeWorkspace/Java"
alias clangd="cd $HOME/OneDrive/CodeWorkspace/C"
alias pyd="cd $HOME/OneDrive/CodeWorkspace/Python"
alias ctext="cd $HOME/OneDrive/CurrTextbooks"
alias scripts="cd $HOME/OneDrive/CodeWorkspace/Scripts"
alias cs240="cd $HOME/OneDrive/2020-21Q2Winter/CSCD240-CandUnix"
alias cs327="cd $HOME/OneDrive/2020-21Q2Winter/CSCD327-RelationalDatabases"
alias cs371="cd $HOME/OneDrive/CodeWorkspace/NET/CSCD371-NETProgramming"
alias cs371a="cd $HOME/OneDrive/CodeWorkspace/NET/Alex_Mia_CSCD371"
alias ma301="cd $HOME/OneDrive/2020-21Q2Winter/MATH301-DiscreteMathematics"
alias 350proj="cd $HOME/OneDrive/CodeWorkspace/CS350Project"
alias dotfiles="xdg-open https://github.com/kaykay38/dotfiles &"
alias canvas="xdg-open https://canvas.ewu.edu/ &"
alias sling="xdg-open https://app.getsling.com/ & disown %1"
alias ccal="xdg-open https://canvas.ewu.edu/calendar &"
alias c371g="xdg-open https://github.com/IntelliTect-Samples/EWU-CSCD371-2021-Winter &"
alias c240="xdg-open https://canvas.ewu.edu/courses/1427733 &"
alias c327="xdg-open https://canvas.ewu.edu/courses/1427835 &"
alias c371="xdg-open https://canvas.ewu.edu/courses/1451913 &"
alias m371b="zathura $HOME/OneDrive/CurrTextbooks/Essential\ C\ Sharp\ 8.0\ by\ Mark\ Michaelis.pdf&"
alias m301="xdg-open https://canvas.ewu.edu/courses/1427319 &"
alias m301b="zathura $HOME/OneDrive/CurrTextbooks/Discrete\ mathematics\ and\ its\ applications\ by\ Rosen,\ Kenneth.pdf &"
alias vpn="$HOME/Security/autovpn"
alias bfg="java -jar /opt/bfg.jar"
alias susp="systemctl suspend"
alias off="poweroff"
alias dis="disown "%$(echo "$(jobs)" | grep 'xdg-open "$url"' | grep -Eo '\[[0-9]+\]' | grep -Eo "[0-9]+")" && echo 'Successfully disowned xdg-open $url'"
function zathuraOpen() {
    zathura $1 &
}
function pacSearch() {
    pacman -Ss "^$1"
}
# # ex - archive extractor
# # usage: ex <file>
function ex ()
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
