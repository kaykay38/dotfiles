" Vim Compiler File
" Compiler:    lualatex
" Maintainer:  Mia Hunt
" Last Change: 2021 April 18
" URL:         https://github.com/kaykay/dotfiles/

if exists("current_compiler")
  finish
endif
let current_compiler = "lualatex"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=lualatex\ \-\-output\-format=pdf\ \-\-file\-line\-error\ \-\-interaction=nonstopmode\ \-shell\-escape\ %\ \\\|\ grep\ \-oP\ '.*:\\d+:.*'

CompilerSet errorformat=%f:%l:\ %m
