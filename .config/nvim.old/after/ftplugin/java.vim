setlocal path=./**,src/**,lib/**,tests/**,bin/**
setlocal include=^\\\s*import\\\s*
set suffixesadd=.java
" set makeprg=javac\ %:S\ 2>&1\ \\\|\ vim-javac-filter
set makeprg=javac\ -g\ %:S
set omnifunc=syntaxcomplete#Complete
" set errorformat=%Z%f:%l:\ %m,%A%p^,%-G%*[^sl]%.%#
set errorformat=%A%f:%l:\ %m,%+Z%p^,%+C%.%#,%-G%.%#
noremap <buffer> <leader>8 :make<cr>:copen<cr>
noremap <buffer> <leader>9 :!echo %\|awk -F. '{print $1}'\|xargs java<cr>
