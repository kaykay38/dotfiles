" Options: {{{
set nocompatible
syntax on
filetype plugin indent on
set lazyredraw
set omnifunc=syntaxcomplete#Complete
set wrap
set linebreak
set breakindent
" I use a unicode curly array with a <backslash><space>
set showbreak=↪>>>
set hidden
set title
set noerrorbells
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ttymouse=sgr
set mouse=a
set smartindent
set relativenumber
set nu
set smartcase
set noswapfile
set nobackup
set undodir=$HOME/.config/nvim/undodir
set undofile
set incsearch
set nohlsearch
set spelllang=en
set scrolloff=5
set cmdheight=1
set shortmess+=c
set updatetime=50
set backspace=indent,eol,start
set signcolumn=yes
set background=dark
set cursorline
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1
set diffopt+=vertical
" }}}
" Plugins: {{{
call plug#begin('$HOME/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'PProvost/vim-ps1'
Plug 'uiiaoo/java-syntax.vim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
call plug#end()
" }}}
" Colors: {{{
" Use truecolor in the terminal, when it is supported
if has('termguicolors')
    set termguicolors
endif
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"
let g:gruvgox_transp_bg=1
let g:gruvgox_italic=1
colorscheme gruvbox
" These preferences clear some gruvbox background colours, allowing transparency
"hi! Normal     ctermbg=NONE guibg=NONE
hi! SignColumn ctermbg=NONE guibg=NONE
hi! VertSplit   ctermbg=59 guibg=#5f5f5f
hi! Todo       ctermbg=NONE guibg=NONE
" }}}
" AutoCompletion: {{{
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}
" COC: {{{
" Use aa to show documentation in preview window.
nnoremap <silent> aa :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" }}}
"Netrw: {{{
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25
" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END
let g:NetrwIsOpen=0
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | let g:NetrwIsOpen=1 | endif 
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
" }}}
" FZF: {{{
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }
"Get Files
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
" Get text in files with Rg
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)
" Ripgrep Root
if executable('rg')
    let g:rg_derive_root='true'
endif
" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" Git grep
command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number '.shellescape(<q-args>), 0,
            \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
" }}}
" Key Mapping: {{{
let mapleader = " "
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
noremap <silent><leader>n :call ToggleNetrw()<CR>
nnoremap <leader>r :%s/
"nnoremap <leader>; :%s/\s*;\s*/;\r/g<CR>
"nnoremap <leader>: :%s/\s*;\s*\n*/; /g<CR>
noremap <F12> :vsp $MYVIMRC<CR>
nnoremap T :set splitbelow<CR>:sp<CR>:term<CR>
vnoremap y ygv
nnoremap <silent><leader>h :wincmd h<CR>
nnoremap <silent><leader>j :wincmd j<CR>
nnoremap <silent><leader>k :wincmd k<CR>
nnoremap <silent><leader>l :wincmd l<CR>
nnoremap <silent><leader>H :wincmd H<CR>
nnoremap <silent><leader>L :wincmd L<CR>
nnoremap <silent><leader>J :wincmd J<CR>
nnoremap <silent><leader>K :wincmd K<CR>
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <silent><leader>d :vsplit<CR>
nnoremap <silent><leader>D :split<CR>
nnoremap <leader>S :w<space>
nnoremap <leader>s :update<CR>
nnoremap <leader>sr :source $MYVIMRC<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>x :xa<CR>
nnoremap vv ^v$
nnoremap vm v$
nnoremap vM v^
nnoremap dm d$
nnoremap dM d^
nnoremap m $
nnoremap M ^
nnoremap <S-Tab> <<
nnoremap <Tab> >>
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
nnoremap <A-k> :m .-2<CR>==
nnoremap <A-j> :m .+1<cr>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <S><CR> O<Esc>
nnoremap <CR> o<Esc>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

nnoremap zk O<Esc>j
nnoremap zj o<Esc>k
nnoremap <leader>fi gg=G<C-o>
nnoremap <leader>a ggVG
nnoremap <leader>u :UndotreeShow<CR>
" coc-snippets
"Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" coc-explorer
nnoremap <leader>e :CocCommand explorer<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>bb :Buffers<CR>
" Ripgrep
nnoremap <leader>g :Rg<CR>
" FZF
nnoremap <C-t> :Tags<CR>
"nnoremap <leader>m :Marks<CR>
" CoC
nmap <silent> gd <Plug>(coc-definition)    
nmap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)    
nmap <silent> gs :exe 'CocList -I --normal --input='.expand('<cword>').' symbols'<CR>
nmap <silent> <leader>rn <Plug>(coc-rename)
" }}}
