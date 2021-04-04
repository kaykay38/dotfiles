setlocal path=./**,src/**,tests/**,bin/**,/usr/lib/python3.8/**,/usr/lib/python2.7/**,/home/mia/.local/lib/python3.8/site-packages/**
setlocal wildignore=*/__pycache__/*,*.pyc
"set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
function! PyInclude(fname)
    let parts = split(a:fname, ' import ') " 1. [conv.metrics] 2. [conv, conversion]
    let l = parts[0]
    if len(parts) > 1
        let r = parts[1] " conversion
        let joined = join([l, r], '.') "conv.conversion
        let fp = substitute(joined, '\.', '/','g') . '.py'
        echo fp
        let found = glob(fp,1)
        if len(found)
            return found
        endif
    endif
    return substitute(joined, '\.', '/','g') . '.py'
endfunction
"setlocal includeexpr=PyInclude(v:fname)
