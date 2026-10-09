#-----------------------------------------------------
# .zshrc
# Author: kaykay38
# Last Modified: Oct 9, 2026
#-----------------------------------------------------

#-------------------------------------------
# ENV VARIABLES 
#-------------------------------------------
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_REQUIRE_TAP_TRUST=1
export CARGO_NET_GIT_FETCH_WITH_CLI=true

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT="/usr/local/share/dotnet"

# [[ $OS = Linux ]] || eval "$(perl -I $HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

export PATH="$DOTNET_ROOT:$PATH"

# ---- pyenv (login shell) ----
export PYENV_ROOT="$HOME/.pyenv"

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

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

# force zsh to show the complete history
alias history="history 0"

#-------------------------------------------
# COMPLETION & MISC.
#-------------------------------------------
setopt autocd               # Allows changing directories by just typing the name (no need for 'cd')
setopt correct              # Automatically suggests corrections for mistyped commands
setopt interactivecomments  # Enables the use of comments (with '#') in interactive shell
setopt magicequalsubst      # Expands filenames in arguments like VAR=path/to/file
setopt nonomatch            # Prevents errors if a glob pattern doesn't match any files
setopt notify               # Immediately notifies when a background job finishes
setopt numericglobsort      # Sorts filenames with numbers in numeric order (e.g., file2 before file10)
setopt promptsubst          # Allows the use of command substitution (e.g., `$(...)`) in the prompt
WORDCHARS=${WORDCHARS//\/}  # Removes '/' from word characters to make tab-completion work better for paths

# TAB COMPLETION 
autoload -Uz compinit && compinit -d "$HOME/.cache/zcompdump"

# Completion behavior settings
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Enables case-insensitive matching for tab completion
zstyle ':completion:*' menu yes select                 # Enables selection interface in completion menu

# Use LS_COLORS for syntax highlighting in completions
[[ -n ${LS_COLORS:-} ]] && zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Completion settings specific to `ls` command
zstyle ':completion:ls:*' menu yes select              # Enables menu selection for `ls` completions

# Show process list for command/process completion
zstyle ':completion:*:processes' command 'ps -U $(whoami)|sed "/ps/d"'    # Lists user processes excluding the `ps` command
zstyle ':completion:*:processes' insert-ids menu yes select               # Allows inserting process IDs from the menu
zstyle ':completion:*:processes-names' command 'ps xho command|sed "s/://g"'  # Lists running process names (cleaned)
zstyle ':completion:*:processes' sort false                               # Disables sorting for process completion entries

#-----------------------------------------------------
# FUNCTIONS 
#-----------------------------------------------------
function git_update() {
    command git rev-parse --git-dir >/dev/null 2>&1 || return

    echo "cd -> $1"
    command git fetch >/dev/null
    command git pull || echo "\033[0;31mgit: failed to pull from remote\033[0m"
}

# search from home, cd into a directory
function fzh() {
    dir="$(fd -t d -c never --base-directory $HOME --ignore-file "$HOME/.config/fd/ignore-home" --search-path $HOME 2>/dev/null | fzf --prompt='Jump to > ' )"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

# search
function fzd() {
    dir="$(fd -H -t d -c never -d 3 | fzf --prompt='Jump to > ' | sed -e "1 s#.#$(pwd)#")"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

# search current and subdirectory, open a file
function fzo() {
    file="$(fd -H -c never -d 3 | fzf --prompt='Open > ')"
    if [[ "$file" ]]; then
        case $(file --mime-type "$file" -bL) in
            text/html) open "$file" || xdg-open "$file"& ;;
            text/*|application/json) $EDITOR "$file" ;;
            *) open "$file" || xdg-open "$file"& ;;
        esac
    fi
}

# search and cd into git repo
function fzg() {
    dir="$(fd -c never -t d -H --ignore-file "$HOME/.config/fd/ignore-git-home" '\.git' --search-path $HOME 2>/dev/null | sed -e 's#/\.git##'  | fzf --prompt='Jump to git repo > ')"
    [[ "$dir" ]] && cd "$dir" && git_update "$dir"
}

function dotfiles() {
    cd "$HOME/.config/.dotfiles" && git_update "$HOME/.config/.dotfiles"
}

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    \rm -f -- "$tmp"
}

# ex - archive extractor
# usage: ex <file>
function ex() {
  if [ $# -ne 1 ]; then
    echo "usage: ex <file>"
    return 1
  fi

  if [ ! -f "$1" ]; then
    echo "'$1' is not a valid file"
    return 1
  fi

  local file="$1"
  local base="${file##*/}"
  local dest

  case "$base" in
    *.tar.bz2) dest="${base%.tar.bz2}" ;;
    *.tar.gz)  dest="${base%.tar.gz}" ;;
    *.tbz2)    dest="${base%.tbz2}" ;;
    *.tgz)     dest="${base%.tgz}" ;;
    *.tar)     dest="${base%.tar}" ;;
    *.zip)     dest="${base%.zip}" ;;
    *.rar)     dest="${base%.rar}" ;;
    *.7z)      dest="${base%.7z}" ;;
    *.bz2)     dest="${base%.bz2}" ;;
    *.gz)      dest="${base%.gz}" ;;
    *.Z)       dest="${base%.Z}" ;;
    *)
      echo "'$file' cannot be extracted via ex()"
      return 1
      ;;
  esac

  if [ -e "$dest" ]; then
    echo "destination '$dest' already exists"
    return 1
  fi

  mkdir "$dest" || return 1

  case "$base" in
    *.tar.bz2) tar xjf "$file" -C "$dest" ;;
    *.tar.gz)  tar xzf "$file" -C "$dest" ;;
    *.tbz2)    tar xjf "$file" -C "$dest" ;;
    *.tgz)     tar xzf "$file" -C "$dest" ;;
    *.tar)     tar xf "$file" -C "$dest" ;;
    *.zip)     unzip "$file" -d "$dest" ;;
    *.rar)     unrar x "$file" "$dest/" ;;
    *.7z)      7z x "$file" -o"$dest" ;;
    *.bz2)     bunzip2 -c "$file" > "$dest/${base%.bz2}" ;;
    *.gz)      gunzip -c "$file" > "$dest/${base%.gz}" ;;
    *.Z)       uncompress -c "$file" > "$dest/${base%.Z}" ;;
  esac
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

#-------------------------------------------
# PROMPT
#-------------------------------------------
NEWLINE=$'\n'
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
RPROMPT='%F{blue} %D{%L:%M:%S %p}%f'

#-------------------------------------------
# git-safeguard
# Snapshot the working tree before any `git restore` / `git checkout`
# so accidental discards (e.g. `git restore .`) stay recoverable.
# On a clean tree this is a silent no-op; on a dirty tree it stores a
# stash WITHOUT touching the working tree, then runs the real command.
# Recover with:  git stash list   then   git stash apply stash@{N}
#-------------------------------------------
git() {
  case "$1" in
    restore|checkout)
      if command git rev-parse --git-dir >/dev/null 2>&1; then
        local _sg_sha
        _sg_sha=$(command git stash create 2>/dev/null)
        if [[ -n "$_sg_sha" ]]; then
          command git stash store \
            -m "git-safeguard: auto-backup before '$1' @ $(date '+%Y-%m-%d %H:%M:%S')" \
            "$_sg_sha" >/dev/null 2>&1
          echo "🛟 git-safeguard: working tree snapshotted before '$1' (recover: git stash list)"
        fi
      fi
      ;;
  esac
  command git "$@"
}

#-----------------------------------------------------
# ALIASES
#-----------------------------------------------------
alias ..="cd .."
alias s="sudo"
alias rm="trash"
case "$(uname -s)" in
  Darwin)
    alias ls='ls -aG'
    alias ll='ls -alG'
    ;;
  *)
    alias ls='ls -a --color=auto'
    alias ll='ls -al --color=auto'
    ;;
esac
alias y="yazi"
alias v="nvim"
alias g="git"
alias gcl="git clone"
alias zrc="$EDITOR $HOME/.zshrc"
alias src="source $HOME/.zshrc"
alias conf="cd $HOME/.config"
alias dwn="cd ~/Downloads"
alias vd="cd $HOME/.config/nvim"
alias vrc="$EDITOR $HOME/.config/nvim/init.lua"
alias codes="cd $SYNCDRIVE/CodeWorkspace"
alias keysha="cd $SYNCDRIVE/CodeWorkspace/Keysha"
alias career="cd $SYNCDRIVE/Career"
alias resume="cd $SYNCDRIVE/Career/Resume"
alias scripts="cd $HOME/Scripts"
alias books="cd $SYNCDRIVE/Books/"
alias classes="cd $SYNCDRIVE/SchoolWork/CurrentClasses/"
alias writing="cd $SYNCDRIVE/Writing"
case "$(uname -s)" in
  Darwin) alias gmail='open https://mail.google.com/mail/u/1/#inbox' ;;
  *)      alias gmail='xdg-open https://mail.google.com/mail/u/1/#inbox' ;;
esac
