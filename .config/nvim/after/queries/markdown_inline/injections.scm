; extends

; Highlight inline `code` spans using the hover's source language (b:ts_hover_lang,
; set on LSP hover floats). The offset strips the surrounding backtick delimiters so
; only the code text is parsed. Ordinary Markdown buffers leave the variable unset,
; so the directive is a no-op there.

((code_span) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#inject-hover-lang! @injection.content))
