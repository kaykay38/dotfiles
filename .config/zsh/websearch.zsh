# web_search from terminal

function web_search() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=(
    $ZSH_WEB_SEARCH_ENGINES
    google      "https://www.google.com/search?q="
    amazon      "https://www.amazon.com/s?k="
    urbandictionary "https://www.urbandictionary.com/define.php?term="
    ebay        "https://www.ebay.com/sch/i.html?_nkw=%s&LH_TitleDesc=1&_sop=12" 
    vimwiki     "https://vim.fandom.com/wiki/Special:Search?search="
    duckduckgo  "https://www.duckduckgo.com/?q="
    github      "https://github.com/search?q="
    baidu       "https://www.baidu.com/s?wd="
    ecosia      "https://www.ecosia.org/search?q="
    goodreads   "https://www.goodreads.com/search?q="
    qwant       "https://www.qwant.com/?q="
    givero      "https://www.givero.com/search?q="
    stackoverflow  "https://stackoverflow.com/search?q="
    wikipedia   "https://en.wikipedia.org/wiki/Special:Search?search="
    wolframalpha   "https://www.wolframalpha.com/input/?i="
    archive     "https://web.archive.org/web/*/"
    scholar        "https://scholar.google.com/scholar?q="
    yahoo       "https://search.yahoo.com/search?p="
    youtube     "https://www.youtube.com/results?search_query="
    googleImages "https://www.google.com/search?tbm=isch&q=" 
  )

  # check whether the search engine is supported
  if [[ -z "$urls[$1]" ]]; then
    echo "Search engine '$1' not supported."
    return 1
  fi

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 1 ]]; then
    # build search url:
    # join arguments passed with '+', then append to search engine URL
    url="${urls[$1]}${(j:+:)@[2,-1]}"
  else
    # build main page url:
    # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
    url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
  fi

  xdg-open "$url" 2>/dev/null& disown '%xdg-open'
}


alias ggl='web_search google'
alias img='web_search googleImages'
alias amzn='web_search amazon'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'
alias gits='web_search github'
alias baidu='web_search baidu'
alias ecosia='web_search ecosia'
alias goodreads='web_search goodreads'
alias qwant='web_search qwant'
alias givero='web_search givero'
alias sof='web_search stackoverflow'
alias wolfalph='web_search wolframalpha'
alias archive='web_search archive'
alias scholar='web_search scholar'
alias wiki='web_search wikipedia'
alias yt='web_search youtube'
alias udic='web_search urbandictionary'

#add your own !bang searches here
alias news='web_search duckduckgo \!n'
alias map='web_search duckduckgo \!m'

# other search engine aliases
if [[ ${#ZSH_WEB_SEARCH_ENGINES} -gt 0 ]]; then
  typeset -A engines
  engines=($ZSH_WEB_SEARCH_ENGINES)
  for key in ${(k)engines}; do
    alias "$key"="web_search $key"
  done
  unset engines key
fi
