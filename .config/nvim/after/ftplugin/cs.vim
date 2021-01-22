setlocal path=.,./**
setlocal include=^\\s*using\\S*
set suffixesadd=.cs,.sln,.csproj,.xaml
set makeprg=dotnet\ build
set omnifunc=syntaxcomplete#Complete
"set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
nnoremap <buffer> aa :OmniSharpDocumentation<CR>
nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
nnoremap <buffer> ggd :OmniSharpPreviewDefinition<CR>
nnoremap <buffer> <leader>b :!cd '%:p:h' && dotnet build<CR>
nnoremap <buffer> <leader>B :CocRebuild<CR>:CocFix<CR>
nnoremap <buffer> <leader>fs :OmniSharpFindSymbol<CR>
nnoremap <buffer> <leader>ff :OmniSharpFindImplementations<CR>
nnoremap <buffer> <leader>fm :OmniSharpFindMembers<CR>
nnoremap <buffer> <leader>i :OmniSharpCodeFormat<CR>
nnoremap <buffer> <leader>rt :OmniSharpRunTestsInFile<CR>
nnoremap <buffer> <leader>ra :OmniSharpRunTest<CR>
nnoremap <buffer> <leader><CR> :OmniSharpGetCodeActions<CR>
nnoremap <buffer> <F5> :set splitbelow<CR>:sp<CR>:term cd '%:p:h' && dotnet run<CR>
