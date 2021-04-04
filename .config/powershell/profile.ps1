Import-Module PSReadLine
Import-Module posh-git
Import-Module oh-my-posh
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PoshPrompt -Theme powerlevel10k_custom_lean
function vposh {nvim "/home/mia/.config/powershell/Modules/oh-my-posh/3.68.4/themes/powerlevel10k_custom_lean.omp.json"}
# New-Alias <alias> <command>       
New-Alias g git
New-Alias open xdg-open
function lc {ls --color $args}
function l {exa --icons $args}
function la {exa -a --icons $args}
function ll {exa -l --icons $args}
function lal {exa -al --icons $args}
function .. {cd ..}
function c`- {cd `-}
New-Alias v nvim
# function <alias> <command>
function vrc {nvim  /home/mia/.config/nvim/init.vim}
function pconf {nvim $profile.currentuserallhosts}
function ggl {
        $query = "https://www.google.com/search?q="
        $args | % { $query = $query + "$_+" }
        $url = $query.Substring(0, $query.Length - 1)
        xdg-open "$url"}
function img {
        $query = "https://www.google.com/search?tbm=isch&q="
        $args | % { $query = $query + "$_+" }
        $url = $query.Substring(0, $query.Length - 1)
        xdg-open "$url"}
function yt {
        $query = "https://www.youtube.com/results?search_query="
        $args | % { $query = $query + "$_+" }
        $url = $query.Substring(0, $query.Length - 1)
        xdg-open "$url"}
function sof {
        $query = "https://stackoverflow.com/search?q="
        $args | % { $query = $query + "$_+" }
        $url = $query.Substring(0, $query.Length - 1)
        xdg-open "$url"}
function gits {
        $query = "https://github.com/search?q="
        $args | % { $query = $query + "$_+" }
        $url = $query.Substring(0, $query.Length - 1)
        xdg-open "$url"}
function icon {
        $query = "https://icons8.com/icons/set/"
        $args | % { $query = $query + "$_-" }
        $url = $query.Substring(0, $query.Length - 1)
        xdg-open "$url"}
function dwn {set-location "/home/mia/Downloads"}
function vd {set-location "/home/mia/.config/nvim"}
function conf {set-location "/home/mia/.config"}
function svd {set-location "/opt/nvim/share/nvim/runtime"}
function oned {set-location "/home/mia/OneDrive"}
function ctext {set-location "/home/mia/OneDrive/CurrTextbooks"}
function codes {set-location "/home/mia/OneDrive/CodeWorkspace"}
function gitd {set-location "/home/mia/OneDrive/CodeWorkspace/Github"}
function cdn {set-location "/home/mia/OneDrive/CodeWorkspace/NET"}
function ewu {set-location "/home/mia/OneDrive/2020-21Q2Winter"}
function cs240 {set-location "/home/mia/OneDrive/2020-21Q2Winter/CSCD240-CandUnix"}
function cs327 {set-location "/home/mia/OneDrive/2020-21Q2Winter/CSCD327-RelationalDatabases"}
function cs371 {set-location "/home/mia/OneDrive/CodeWorkspace/NET/CSCD371-NETProgramming"}
function cs371a {set-location "/home/mia/OneDrive/CodeWorkspace/NET/Alex_Mia_CSCD371"}
function ma301 {set-location "/home/mia/OneDrive/2020-21Q2Winter/MATH301-DiscreteMathematics"}
function dotfiles {xdg-open "https://github.com/kaykay38/dotfiles"}
function canvas {xdg-open "https://canvas.ewu.edu/"}
function ccal {xdg-open "https://canvas.ewu.edu/calendar#view_name=month&view_start="}
function c371g {xdg-open "https://github.com/IntelliTect-Samples/EWU-CSCD371-2021-Winter"}
function c240 {xdg-open "https://canvas.ewu.edu/courses/1427733"}
function c327 {xdg-open "https://canvas.ewu.edu/courses/1427835"}
function c371 {xdg-open "https:/canvas.ewu.edu/courses/1451913"}
function c371b {xdg-open "/home/mia/OneDrive/CurrTextbooks/Essential C Sharp 8.0 by Mark Michaelis.pdf"}
function m301 {xdg-open "https://canvas.ewu.edu/courses/1427319"}
function m301b {xdg-open "/home/mia/OneDrive/CurrTextbooks/Discrete mathematics and its applications by Rosen, Kenneth.pdf"}
$Env:LF_ICONS='\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
'
