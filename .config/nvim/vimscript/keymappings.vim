" Key Mapping: {{{
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
" nnoremap <leader>r :%s/
"nnoremap <leader>; :%s/\s*;\s*/;\r/g<CR>
"nnoremap <leader>: :%s/\s*;\s*\n*/; /g<CR>
noremap <F12> :vsp $MYVIMRC<CR>
nnoremap <leader>sr :luafile $MYVIMRC<CR>
nnoremap r <Nop>
nnoremap <leader>r <space>r


nnoremap T :set splitbelow<CR>:sp<CR>:term<CR>a

nnoremap <leader>S :w<space>
nnoremap <leader>s :update<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>x :xa<CR>
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
nnoremap <silent> + :resize +5<CR>
nnoremap <silent> _ :resize -5<CR>
" nnoremap <leader>t :tabnew<CR>
nnoremap <leader>t <space>t
nnoremap <A-H> :tabprevious<CR>
nnoremap <A-L> :tabnext<CR>
nnoremap <silent><leader>d <leader>d
nnoremap <silent><leader>D <leader>D
nnoremap <silent><leader>d <leader>d
nnoremap <silent><leader>D <leader>D

nnoremap vv ^v$h
nnoremap vm v$
nnoremap vM v^
nnoremap dm d$
nnoremap dM d^
nnoremap m $
nnoremap M ^

inoremap <A-j> <Esc>gja
inoremap <A-k> <Esc>gka
inoremap <A-h> <Left>
inoremap <A-l> <Right>

nnoremap <A-j> gj
nnoremap <A-k> gk
vnoremap <A-j> gj
vnoremap <A-k> gk
vnoremap <A-h> <Left>
vnoremap <A-l> <Right>

nnoremap <S-Tab> <<
nnoremap <Tab> >>
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

inoremap <silent><A-J> <Esc>:m .+1<CR>==gi
inoremap <silent><A-K> <Esc>:m .-2<CR>==gi
nnoremap <silent><A-J> :m .+1<cr>==
nnoremap <silent><A-K> :m .-2<CR>==
vnoremap <silent><A-J> :m '>+1<CR>gv=gv
vnoremap <silent><A-K> :m '<-2<CR>gv=gv

nnoremap zk O<Esc>
nnoremap zj o<Esc>
nnoremap <leader>fi gg=G<C-o>
nnoremap <leader>a ggVG
"Plugin Key Mappings: {{{
nnoremap <silent><leader>e :NvimTreeToggle<CR>
nnoremap <silent><leader>/ :CommentToggle<CR>
vnoremap <silent><leader>/ :CommentToggle<CR>
nnoremap <leader>f :Files<CR>
nnoremap <A-b> :Buffers<CR>
" Ripgrep
nnoremap <leader>g :Rg<CR>
" FZF
nnoremap <C-t> :Tags<CR>
"}}}
