;; extends

(table
 (bare_key) @table-name (#any-of? @table-name "templates" "template-aliases")
 [(pair (_) ((string) @injection.content (#set! injection.language "jjtemplate"))) (comment)]
 (#match? @injection.content "^\"\"\"|^\'\'\'")
 (#offset! @injection.content 0 3 0 -3))

(table
 (bare_key) @table-name (#any-of? @table-name "templates" "template-aliases")
 [(pair (_) ((string) @injection.content (#set! injection.language "jjtemplate"))) (comment)]
 (#match? @injection.content "^\"[^\"]|^\'[^\']")
 (#offset! @injection.content 0 1 0 -1))

(table
 (bare_key) @table-name (#any-of? @table-name "revsets" "revset-aliases")
 [(pair (_) ((string) @injection.content (#set! injection.language "jjrevset"))) (comment)]
 (#match? @injection.content "^\"\"\"|^\'\'\'")
 (#offset! @injection.content 0 3 0 -3))

(table
 (bare_key) @table-name (#any-of? @table-name "revsets" "revset-aliases")
 [(pair (_) ((string) @injection.content (#set! injection.language "jjrevset"))) (comment)]
 (#match? @injection.content "^\"[^\"]|^\'[^\']")
 (#offset! @injection.content 0 1 0 -1))
