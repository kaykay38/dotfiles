# Grep & Find functions and aliases
sfind() {
   sudo find / -iname "*$*" 
}
scurfind() {
   sudo find . -iname "*$**" 
}
homefind() {
    find /home/mia -iname "*$**"
}
curfind() {
    find . -iname "*$**"
}
rootgrep() {
    sudo grep -rnw / -e "$*"
}
scurgrep() {
    sudo grep -rnw . -e "$*"
}
homegrep() {
    grep -rnw /home/mia -e "$*"
}
curgrep() {
    grep -rnw . -e "$*"
}
alias sgrep=scurgrep
alias rgrep=rootgrep
alias hgrep=homegrep
alias -g cgrep=curgrep
alias sf=sfind
alias sf.=scurfind
alias f=homefind
alias f.=curfind
