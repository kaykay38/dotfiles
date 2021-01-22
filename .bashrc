#-------------------------------------------
# PROMPT
#-------------------------------------------
source .p10k.zsh
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
HISTFILE=~/.zsh_history
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
if [ -f $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && [ "$color_prompt" = yes ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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
# COMPLETION 
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
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion
zstyle ':completion:*' menu yes select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:ls:*' menu yes select
    # Take advantage of $LS_COLORS for completion as well
zstyle ':completion:*:processes' command 'ps -U $(whoami)|sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'ps xho command|sed "s/://g"'
zstyle ':completion:*:processes' sort false 
#------------------------------------------
# PLUGINS & SCRIPTS
#-------------------------------------------
source ~/.config/zsh/find.zsh
source ~/.config/zsh/alacritty-win-title.zsh
source ~/.config/zsh/websearch.zsh
source ~/.config/zsh/zsh-autosuggestions
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
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
alias zrc="nvim $HOME/.zshrc"
alias src="source $HOME/.zshrc"
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
alias vpn="sudo $HOME/.config/.startup/ewuVPN.sh"
