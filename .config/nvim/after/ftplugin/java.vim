setlocal path=./**,src/**,lib/**,tests/**,bin/**
setlocal include=^\\\s*import\\\s*
set suffixesadd=.java
set makeprg=javac\ -g\ \"%:p\"
set omnifunc=syntaxcomplete#Complete
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
noremap <buffer> <leader>8 :make<cr>:copen<cr>
noremap <buffer> <leader>9 :!echo %\|awk -F. '{print $1}'\|xargs java<cr>
