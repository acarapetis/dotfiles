;; extends
(
    (string_content) @injection.content
    (#match? @injection.content "^\\/\\*SQL\\*\\/")
    (#set! injection.language "sql")
)

; inline queries in tree_sitter:
(call 
  function: (identifier) @callable
  arguments: (argument_list (_) (string (string_content) @injection.content))
  (#eq? @callable "Query")
  (#set! injection.language "query")

