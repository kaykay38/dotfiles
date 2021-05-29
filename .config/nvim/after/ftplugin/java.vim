setlocal path=./**,src/**,lib/**,tests/**,bin/**
setlocal include=^\\\s*import\\\s*
set suffixesadd=.java
set makeprg=javac\ -g\ %:S
set omnifunc=syntaxcomplete#Complete
set errorformat=%A%f:%l:\ %m,%+Z%p^,%+C%.%#,%-G%.%#
nnoremap <buffer> F8 :make<cr>:copen<cr>
nnoremap <buffer> F9 :!echo %\|awk -F. '{print $1}'\|xargs java<cr>
nnoremap <buffer> <C-h> :cprevious<CR> 
nnoremap <buffer> <C-l> :cnext<CR>
