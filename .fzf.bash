# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mia/.local/share/nvim/site/pack/packer/start/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/mia/.local/share/nvim/site/pack/packer/start/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mia/.local/share/nvim/site/pack/packer/start/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/mia/.local/share/nvim/site/pack/packer/start/fzf/shell/key-bindings.bash"
