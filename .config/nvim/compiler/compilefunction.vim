" Compile Function: {{{
    func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
            exec "!gcc \"%\" -o \"%<\""
            set splitbelow
            :sp
            :term cd "%:p:h" && time ./%:t:r
        elseif &filetype == 'java'
            let binPath = substitute('%:r', '\/src\/', '\/bin\/','')
            exec "!javac --release 14 --enable-preview -cp \"lib/*\" \"%:p\" -d \"".binPath."\""
            set splitbelow
        elseif &filetype == 'cs'
            exec "!csc \"%\""
            set splitbelow
            :sp
            :term "time dotnet run"
        elseif &filetype == 'cpp'
            exec "!g++ -std=c++11 \"%\" -Wall -o \"%<\""
            set splitbelow
            :sp
            :res -15
            :term ./%<
        elseif &filetype == 'sh'
            :!time bash "%"
        elseif &filetype == 'python'
            set splitbelow
            :sp
            :term python3 "%"
        elseif &filetype == 'html'
            silent! exec "!".g:mkdp_browser." \"%\" &"
        elseif &filetype == 'markdown'
            exec "InstantMarkdownPreview"
        elseif &filetype == 'tex
            silent! exec "VimtexStop"
            silent! exec "VimtexCompile"
        elseif &filetype == 'dart'
            exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
            silent! exec "CocCommand flutter.dev.openDevLog"
        elseif &filetype == 'javascript'
            set splitbelow
            :sp
            :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
        elseif &filetype == 'go'
            set splitbelow
            :sp
            :term go run .
        endif
    endfunc
" }}}
