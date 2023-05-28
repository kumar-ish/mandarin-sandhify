(lang dune 3.7)

(name mandarin_sandhify)

(generate_opam_files false)

; (source
;  (github username/reponame))

(authors "Madhav K")

(maintainers "Madhav K")

(license MIT)

; (documentation https://url/to/documentation)

(package
 (name mandarin_sandhify)
 (synopsis "Tranforms Pinyin to a form that accounts for tone sandhi")
 (description "The way you pronounce Chinese characters at times from the Pinyin for those characters, depending on the context around that character -- this is called tone sandhi. This tool transforms Pinyin to a form that's pronounceable as-is.")
 (depends ocaml dune)
 (tags
  (topics "mandarin" "sandhi" "language")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
