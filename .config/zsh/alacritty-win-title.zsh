# Alacritty window title
if [[ "${TERM}" != "" && "${TERM}" == "alacritty" ]]
then
    precmd()
    {
        # output on which level (%L) this shell is running on.
        # append the current directory (%~), substitute home directories with a tilde.
        # "\a" bell (man 1 echo)
        # "print" must be used here; echo cannot handle prompt expansions (%L)
        print -Pn "\e]0;$(id --user --name): zsh %~\a"
    }

    preexec()
    {
        # output current executed command with parameters
        echo -en "\e]0;$(id --user --name): ${1}\a"
    }
fi
