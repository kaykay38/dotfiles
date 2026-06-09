" let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>d :call vimspector#Launch()<CR>
nmap <F5> :call vimspector#Continue()<CR>
nmap <F3> :call vimspector#Stop()<CR>
nmap <F4> :call vimspector#Restart()<CR>
nmap <F6> :call vimspector#Pause()<CR>
nmap <F9> :call vimspector#ToggleBreakpoint()<CR>
nmap <leader><F9> :call vimspector#ToggleConditionalBreakpoint()<CR>
nmap <F8> :call vimspector#AddFunctionBreakpoint()<CR>
nmap <leader><F8> :call vimspector#RunToCursor()<CR>
nmap <F10> :call vimspector#StepOver()<CR>
nmap <F11> :call vimspector#StepInto()<CR>
nmap <F12> :call vimspector#StepOut()<CR>
" <Plug>VimspectorContinue	When debugging, continue. Otherwise start debugging.	vimspector#Continue()
" <Plug>VimspectorStop	Stop debugging.	vimspector#Stop()
" <Plug>VimpectorRestart	Restart debugging with the same configuration.	vimspector#Restart()
" <Plug>VimspectorPause	Pause debuggee.	vimspector#Pause()
" <Plug>VimspectorToggleBreakpoint	Toggle line breakpoint on the current line.	vimspector#ToggleBreakpoint()
" <Plug>VimspectorToggleConditionalBreakpoint	Toggle conditional line breakpoint on the current line.	vimspector#ToggleBreakpoint( { trigger expr, hit count expr } )
" <Plug>VimspectorAddFunctionBreakpoint	Add a function breakpoint for the expression under cursor	vimspector#AddFunctionBreakpoint( '<cexpr>' )
" <Plug>VimspectorRunToCursor	Run to Cursor	vimspector#RunToCursor()
" <Plug>VimspectorStepOver	Step Over	vimspector#StepOver()
" <Plug>VimspectorStepInto	Step Into	vimspector#StepInto()
" <Plug>VimspectorStepOut	Step out of current function scope	vimspector#StepOut()
" <Plug>VimspectorUpFrame	Move up a frame in the current call stack	vimspector#UpFrame()
" <Plug>VimspectorDownFrame	Move down a frame in the current call stack	vimspector#DownFrame()
" <Plug>VimspectorBalloonEval	Evaluate expression under cursor (or visual) in popup	
