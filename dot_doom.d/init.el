;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom install'
;; will do this for you). The `doom!' block below controls what modules are
;; enabled and in what order they will be loaded. Remember to run 'doom refresh'
;; after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.

(doom! :completion
       (company +auto
                +childframe)
       (ivy +fuzzy
            +prescient
            +icons)

       :ui
       deft
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       fill-column       ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       indent-guides     ; highlighted indent columns
       modeline          ; snazzy, Atom-inspired modeline, plus API
       minimap
       nav-flash         ; blink the current line after jumping
       ophints           ; highlight the region an operation acts on
       (popup            ; tame sudden yet inevitable temporary windows
        +defaults)       ; default popup rules
       treemacs          ; a project drawer, like neotree but cooler
       tabs
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces
       zen

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       ;;parinfer          ; turn lisp into python, sort of
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to

       :emacs
       (dired +ranger
              +icons)             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       (ibuffer +icons)           ; interactive buffer management
       undo
       vc                ; version-control and Emacs, sitting in a tree

       :term
       term

       :checkers
       syntax              ; tasing you for every semicolon you forget
       spell             ; tasing you for misspelling mispelling
       grammar           ; tasing grammar mistake every you make

       :tools
       ansible
       ;;docker
       editorconfig      ; let someone else argue about tabs vs spaces
       (eval +overlay)     ; run code, run (also, repls)
       ;;gist              ; interacting with github gists
       (lookup           ; helps you navigate your code and documentation
        +dictionary
        +docsets)        ; ...or in Dash docsets locally
       lsp
       (magit +forge)             ; a git porcelain for Emacs
       ;;make              ; run make tasks from Emacs
       ;;pdf               ; pdf enhancements
       rgb               ; creating color strings
       ;;tmux              ; an API for interacting with tmux
       taskrunner
                                        ;,upload            ; map local to remote projects via ssh/ftp

       :os
       (:if IS-MAC macos)

       :lang
       (clojure)           ; java with a lisp
       common-lisp       ; if you've seen one lisp, you've seen them all
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       (javascript +lsp)
       latex             ; writing papers in Emacs has never been so fun
       markdown          ; writing docs for people to ignore
       nix
       (yaml +lsp)
       (org
        +dragndrop
        +gnuplot
        +journal
        +jupyter
        +pandoc
        +present
        +pretty
        +roam)
       (php               ; perl's insecure younger brother
        +lsp)
       (python            ; beautiful is better than ugly
        +pyenv
        +lsp)
       ruby
       ;;rest              ; Emacs as a REST client
       ;;rst
       (sh +lsp)                ; she sells {ba,z,fi}sh shells on the C xor
       web               ; the tubes

       :config

       (default +bindings +smartparens))
