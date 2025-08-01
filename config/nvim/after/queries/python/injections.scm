;; extends

; explicitly tagged sql strings
(
    (string_content) @injection.content
    (#match? @injection.content "^\\/\\*SQL\\*\\/")
    (#set! injection.language "sql")
)

; literal sql in alembic migrations:
(call 
  function: (attribute (identifier) @op (identifier) @execute) @callable
  arguments: (argument_list . (string (string_content) @injection.content))
  (#eq? @op "op")
  (#eq? @execute "execute")
  (#set! injection.language "sql"))

; inline queries in tree_sitter:
(call 
  function: (identifier) @callable
  arguments: (argument_list (_) (string (string_content) @injection.content))
  (#eq? @callable "Query")
  (#set! injection.language "query"))

