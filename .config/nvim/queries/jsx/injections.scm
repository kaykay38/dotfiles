; extends

; styled-jsx: <style jsx>{`...`}</style> and <style jsx global>{`...`}</style>
(jsx_element
  open_tag: (jsx_opening_element
    name: (identifier) @_tag
    attribute: (jsx_attribute
      (property_identifier) @_attr)
    (#eq? @_tag "style")
    (#eq? @_attr "jsx"))
  (jsx_expression
    (template_string) @injection.content)
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "css")
  (#set! injection.include-children))
