;; extends
(
    (string_content) @injection.content
    (#any-match? @injection.content "^\\/\\*SQL\\*\\/")
    (#set! injection.language "sql")
)
