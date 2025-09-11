; This is the stock injections minus the shell_command bash highlighting, which triggers
; a bug somewhere:
; https://github.com/camdencheek/tree-sitter-dockerfile/issues/51
; Note that we're *not* extending existing queries, we're replacing them entirely, thus
; this file not living in after/.

((comment) @injection.content
  (#set! injection.language "comment"))

((run_instruction
  (heredoc_block) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.include-children))
