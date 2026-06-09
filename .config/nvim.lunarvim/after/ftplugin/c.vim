setlocal path=.,./**
setlocal include=^\\s*#include\\S*
set suffixesadd=.c,.h
set makeprg=gcc\ '%:p'\ -g\ -o\ '%:p:r'\ -lm
nnoremap <buffer><leader>b :make<CR>
nnoremap <buffer><leader>m :copen<CR>
nnoremap <buffer><leader>i :cnext<CR>
nnoremap <buffer><leader>o :cprev<CR>
nnoremap <buffer><leader><CR> :CocAction<CR>
nnoremap <buffer><leader>rr :set splitbelow<bar>:sp<bar>:term time "%:p:r"<CR>
