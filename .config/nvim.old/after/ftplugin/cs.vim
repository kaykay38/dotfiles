setlocal path=.,./**
setlocal include=^\\s*using\\S*
set suffixesadd=.cs,.sln,.csproj,.xaml
set omnifunc=syntaxcomplete#Complete
nnoremap <buffer> aa :OmniSharpDocumentation<CR>
nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
nnoremap <buffer> gi :OmniSharpFindImplementations<CR>
nnoremap <buffer> gm :OmniSharpFindMembers<CR>
nnoremap <buffer> gs :OmniSharpFindSymbol<CR>
nnoremap <buffer> gu :OmniSharpFindUsages<CR>
nnoremap <buffer> <leader>i :OmniSharpCodeFormat<CR>
nnoremap <buffer> ggd :OmniSharpPreviewDefinition<CR>
nnoremap <buffer> ggi :OmniSharpPreviewImplementation<CR>
nnoremap <buffer> <leader>b :make<bar>:copen<CR>
nnoremap <buffer> <leader>B :CocRebuild<CR>:CocFix<CR>
nnoremap <buffer> <leader>cc :copen<CR>
nnoremap <buffer> <leader>ci :cnext<CR>
nnoremap <buffer> <leader>co :cprev<CR>
nnoremap <buffer> <leader>fu :OmniSharpFixUsings<CR>
nnoremap <buffer> <leader>ra :OmniSharpRunTest<CR>
nnoremap <buffer> <leader>rr :OmniSharpRename
nnoremap <buffer> <leader>rt :OmniSharpRunTestsInFile<CR>
nnoremap <buffer> <leader><CR> :OmniSharpGetCodeActions<CR>
nnoremap <buffer> <F5> :set splitbelow<CR>:sp<CR>:term cd '%:p:h' && dotnet run<CR>
