" VSCode Neovim Config: {{{
if exists('g:vscode')
    source $HOME/.vim/vscode.vim
else
    " }}}
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
    set noshowmode
    set noerrorbells
    set expandtab
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set mouse=a
    set smartindent
    set relativenumber
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
    let g:auto_save = 1
    let g:auto_save_in_insert_mode = 0
    let g:auto_save_silent = 1
    set fillchars+=vert:\  
    set diffopt+=vertical
    " Save folds
    autocmd BufWrite * mkview
    " Load folds
    autocmd BufRead * silent! loadview
    " }}}
    " Lua: {{{
    augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    augroup END
    " }}}
    " Plugins: {{{
    call plug#begin('~/.config/nvim/plugged')
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'itchyny/lightline.vim'
    Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'maximbaz/lightline-ale'
    Plug 'mbbill/undotree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'dense-analysis/ale'
    " Plug 'sirver/ultisnips'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'neovim/nvim-lspconfig'
    "Plug 'xolox/vim-lua-ftplugin'
    "Plug 'xolox/vim-misc'
    Plug 'PProvost/vim-ps1'
    Plug 'uiiaoo/java-syntax.vim'
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'lervag/vimtex'
    " Plug 'nvim-treesitter/nvim-treesitter', {'commit': '3c07232'}
    call plug#end()
    " }}}
    " Colors: {{{
    " Use truecolor in the terminal, when it is supported
    if has('termguicolors')
        set termguicolors
        lua require'colorizer'.setup()
    endif
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    "let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"
    let g:gruvgox_italic=1
    let g:gruvgox_transp_bg=1
    colorscheme gruvbox8
    " These preferences clear some gruvbox background colours, allowing transparency
    hi! Normal     ctermbg=NONE guibg=NONE
    hi! SignColumn ctermbg=NONE guibg=NONE
    hi! VertSplit   ctermbg=59 guibg=#5f5f5f
    hi! Todo       ctermbg=NONE guibg=NONE
    " Syntax Highlighting: {{{
    " }}}
    " }}}
    " Lightline: {{{
    let g:lightline = {
                \ 'colorscheme':'gruvbox',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
                \   'right': [
                \     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
                \     ['lineinfo'], ['percent'],
                \     ['filetype']
                \   ]
                \ },
                \ 'inactive': {
                \   'right': [['lineinfo'], ['percent']]
                \ },
                \ 'component_function': {
                \   'gitbranch': 'FugitiveHead'
                \ },
                \ 'mode_map': {
                \ 'n' : 'N',
                \ 'i' : 'I',
                \ 'R' : 'R',
                \ 'v' : 'V',
                \ 'V' : 'VL',
                \ "\<C-v>": 'VB',
                \ 'c' : 'C',
                \ 's' : 'S',
                \ 'S' : 'SL',
                \ "\<C-s>": 'SB',
                \ 't': 'T',
                \ },
                \ 'component': {
                \   'lineinfo': '%3l:%-2v%<',
                \ },
                \ 'component_expand': {
                \   'linter_checking': 'lightline#ale#checking',
                \   'linter_infos': 'lightline#ale#infos',
                \   'linter_warnings': 'lightline#ale#warnings',
                \   'linter_errors': 'lightline#ale#errors',
                \   'linter_ok': 'lightline#ale#ok'
                \  },
                \ 'component_type': {
                \   'linter_checking': 'right',
                \   'linter_infos': 'right',
                \   'linter_warnings': 'warning',
                \   'linter_errors': 'error',
                \   'linter_ok': 'right'
                \  },
                \}
    function! LightlineFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction
    function! LightlineFiletype()
        return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
    endfunction
    " Use unicode chars for ale indicators in the statusline
    let g:lightline#ale#indicator_checking = "\uf110 "
    let g:lightline#ale#indicator_infos = "\uf129 "
    let g:lightline#ale#indicator_warnings = "\uf071 "
    let g:lightline#ale#indicator_errors = "\uf05e "
    let g:lightline#ale#indicator_ok = "\uf00c "
    " }}}
    " AutoCompletion: {{{
    "let g:ycm_global_ycm_extra_conf = '$HOME/.vim/plugged/YouCompleteMe/ycm_extra_conf.py'
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    " }}}
    " ALE: {{{
    let g:ale_sign_error = '•'
    let g:ale_sign_warning = '•'
    let g:ale_sign_info = '·'
    let g:ale_sign_style_error = '·'
    let g:ale_sign_style_warning = '·'
    let g:ale_linters = { 'cs': ['syntax','semantic', 'issues'], 'python': ['pylint'],'java':['javac']}
    let g:ale_fixers={'*':[],'python':['black','isort']}
    " }}}
    " COC: {{{
    " Use K to show documentation in preview window.
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
    " Snippets: {{{
    " Set this to 1 to use ultisnips for snippet handling
    let s:using_snippets = 1
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-f>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"
    let g:UltiSnipsSnippetDirectories = ['$HOME/.config/nvim/plugged/ultisnips', 'UltiSnips']
    let g:UltiSnipsSnippetsDir="$HOME/.config/nvim/plugged/ultisnips"
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
    " Markdown Preview: {{{
    " set to 1, nvim will open the preview window after entering the markdown buffer
    " default: 0
    let g:mkdp_auto_start = 0
    " set to 1, the nvim will auto close current preview window when change
    " from markdown buffer to another buffer
    " default: 1
    let g:mkdp_auto_close = 1
    " set to 1, the vim will refresh markdown when save the buffer or
    " leave from insert mode, default 0 is auto refresh markdown as you edit or
    " move the cursor
    " default: 0
    let g:mkdp_refresh_slow = 0
    " set to 1, the MarkdownPreview command can be use for all files,
    " by default it can be use in markdown file
    " default: 0
    let g:mkdp_command_for_global = 0
    " set to 1, preview server available to others in your network
    " by default, the server listens on localhost (127.0.0.1)
    " default: 0
    let g:mkdp_open_to_the_world = 0
    " use custom IP to open preview page
    " useful when you work in remote vim and preview on local browser
    " more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
    " default empty
    let g:mkdp_open_ip = ''
    " specify browser to open preview page
    " default: ''
    let g:mkdp_browser = ''
    " set to 1, echo preview page url in command line when open preview page
    " default is 0
    let g:mkdp_echo_preview_url = 0
    " a custom vim function name to open preview page
    " this function will receive url as param
    " default is empty
    let g:mkdp_browserfunc = ''
    " options for markdown render
    " mkit: markdown-it options for render
    " katex: katex options for math
    " uml: markdown-it-plantuml options
    " maid: mermaid options
    " disable_sync_scroll: if disable sync scroll, default 0
    " sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
    "   middle: mean the cursor position alway show at the middle of the preview page
    "   top: mean the vim top viewport alway show at the top of the preview page
    "   relative: mean the cursor position alway show at the relative positon of the preview page
    " hide_yaml_meta: if hide yaml metadata, default is 1
    " sequence_diagrams: js-sequence-diagrams options
    " content_editable: if enable content editable for preview page, default: v:false
    " disable_filename: if disable filename header for preview page, default: 0
    let g:mkdp_preview_options = {
                \ 'mkit': {},
                \ 'katex': {},
                \ 'uml': {},
                \ 'maid': {},
                \ 'disable_sync_scroll': 0,
                \ 'sync_scroll_type': 'middle',
                \ 'hide_yaml_meta': 1,
                \ 'sequence_diagrams': {},
                \ 'flowchart_diagrams': {},
                \ 'content_editable': v:false,
                \ 'disable_filename': 0
                \ }
    " use a custom markdown style must be absolute path
    " like '/Users/username/markdown.css' or expand('~/markdown.css')
    let g:mkdp_markdown_css = ''
    " use a custom highlight style must absolute path
    " like '/Users/username/highlight.css' or expand('~/highlight.css')
    let g:mkdp_highlight_css = ''
    " use a custom port to start server or random for empty
    let g:mkdp_port = ''
    " preview page title
    " ${name} will be replace with the file name
    let g:mkdp_page_title = '「${name}」'
    " recognized filetypes
    " these filetypes will have MarkdownPreview... commands
    let g:mkdp_filetypes = ['markdown']
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
    nnoremap <leader>c "+y
    nnoremap <leader>C "+Y
    vnoremap <leader>c "+ygv
    vnoremap <leader>C "+ygv
    nnoremap <leader>v "+p
    nnoremap <leader>V "+P
    vnoremap <leader>v "+pgv
    vnoremap <leader>V "+Pgv
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
endif
