; extends

; Highlight code blocks that do not name a language using the source language of
; the surrounding buffer, exposed as `b:ts_hover_lang`. LSP hover floats set this
; (see init.lua); ordinary Markdown buffers leave it unset, so the directive is a
; no-op there and normal prose rendering is untouched.
;
; SourceKit (and many other servers) emit example code as indented blocks or as
; bare ``` fences with no info string, which otherwise render unhighlighted. The
; directive skips fenced blocks that already name a language, so labeled fences
; keep their own highlighting.

((indented_code_block) @injection.content
  (#inject-hover-lang! @injection.content))

((fenced_code_block
  (code_fence_content) @injection.content) @_block
  (#inject-hover-lang! @_block))
