
    set scrolloff=5
    function! s:split(...) abort
        let direction = a:1
        let file = exists('a:2') ? a:2 : ''
        call VSCodeCall(direction ==# 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
        if !empty(file)
            call VSCodeExtensionNotify('open-file', expand(file), 'all')
        endif
    endfunction
    function! s:splitNew(...)
        let file = a:2
        call s:split(a:1, empty(file) ? '__vscode_new__' : file)
    endfunction
    function! s:manageEditorSize(...)
        let count = a:1
        let to = a:2
        for i in range(1, count ? count : 1)
            call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
        endfor
    endfunction
    imap <A-j> <Down>
    imap <A-k> <Up>
    imap <A-h> <Left>
    imap <A-l> <Right>
    noremap c "*y
    noremap C "+y
    noremap <space>v "*p
    noremap <space>V "+p
    nmap <space>m ^
    nmap m $
    nmap dm d$
    nmap <space>b <C-v>
    nmap <space>s :update<CR>
    nmap <space>nv :vnew<CR>
    nmap <space>nh :new<CR>
    nmap fi gg=G<C-o><C-o>
    nmap sa ggVG
    nmap <S><CR> O<ESC>
    nmap <CR> o<ESC>
    nmap <space>s :update<CR>
    nmap <silent> <space>= :vertical resize +5<CR>
    nmap <silent> <space>- :vertical resize -5<CR>
    nmap <space>h <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
    nmap <space>k <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
    nmap <space>j <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
    nmap <space>l <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
    nmap <space>H <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
    nmap <space>J <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
    nmap <space>K <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
    nmap <space>L <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
    nmap <space>d <Cmd>call <SID>split('v')<CR>
    nmap <space>D <Cmd>call <SID>split('h')<CR>
    nmap <space>. <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xmap <space>. <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nmap <space>= <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xmap <space>= <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nmap <space>, <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xmap <space>, <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    nmap <space>- <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xmap <space>- <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
