;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Tim Kleinschmidt"
      user-mail-address "tim.kleinschidt@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :line-spacing 1.2)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono")
      doom-big-font (font-spec :family "JetBrains Mono" :size 20))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; MISC
(add-hook 'window-setup-hook #'toggle-frame-maximized)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))

;; Magit
(setq magit-repository-directories '(("~/" . 2))
      magit-save-repository-buffers nil
      transient-values '((magit-commit "--gpg-sign=3F74D3A286A02EED")
                         (magit-rebase "--autosquash" "--gpg-sign=3F74D3A286A02EED")
                         (magit-pull "--rebase" "--gpg-sign=3F74D3A286A02EED")))
(remove-hook 'server-switch-hook 'magit-commit-diff)


;; Clojurescript
(setq cider-boot-parameters "dev --cider")

(with-eval-after-load "format-all"
  (define-format-all-formatter cljfmt
    (:executable "cljfmt")
    (:install "")
    (:modes clojure-mode clojurec-mode clojurescript-mode)
    (:format (format-all--buffer-easy executable "fix" "-"))))

(setq-hook! 'python-mode-hook +format-with 'ruff)

(evil-define-key 'normal clojure-mode-map
  ">"  'sp-forward-slurp-sexp
  "<"  'sp-forward-barf-sexp)

(evil-define-key 'normal clojurescript-mode-map
  ">"  'sp-forward-slurp-sexp
  "<"  'sp-forward-barf-sexp)

(evil-define-key 'normal emacs-lisp-mode-map
  ">"  'sp-forward-slurp-sexp
  "<"  'sp-forward-barf-sexp)

(map! :map (clojure-mode-map clojurescript-mode-map emacs-lisp-mode-map)
      :after clojure-mode
      :localleader
      :desc "Wrap round"            "("     'sp-wrap-round
      :desc "Wrap curly"            "{"     'sp-wrap-curly
      :desc "Wrap square"           "["     'sp-wrap-square
      )

(map! :leader
      :desc "Switch to last buffer"     "TAB"   'evil-switch-to-windows-last-buffer
      :desc "Search in project"         "/"     '+default/search-project
      :desc "Split vertically"          "w /"   'evil-window-vsplit
      :desc "Split horizontally"        "w -"   'evil-window-split
      :desc "Comment"                   ";"     'comment-or-uncomment-region
      :desc "Edit all occurrences"      "s e"   'evil-multiedit-match-all
      :desc "Expand region"             "v"     'er/expand-region
      (:prefix-map ("a" . "app")
       :desc "Open overview"           "v"      'open-overview
       )
      :desc "Recent searches"          "\\"     'vertico-repeat-select
      (:prefix-map ("l" . "lisp")
       :desc "Slurp"                   "s"     'sp-forward-slurp-sexp
       :desc "Slurp backwards"         "S"     'sp-backward-slurp-sexp
       :desc "Barf"                    "b"     'sp-forward-barf-sexp
       :desc "Barf backwards"          "B"     'sp-backward-barf-sexp
       :desc "Join"                    "j"     'sp-join-sexp
       :desc "Split"                   "c"     'sp-split-sexp
       :desc "Transpose"               "t"     'sp-transpose-sexp
       :desc "Raise"                   "r"     'sp-raise-sexp
       (:prefix-map ("w" . "wrap")
        :desc "Wrap round"            "("     'sp-wrap-round
        :desc "Wrap curly"            "{"     'sp-wrap-curly
        :desc "Wrap square"           "["     'sp-wrap-square
        )))


(map! :map (clojure-mode-map clojurescript-mode-map emacs-lisp-mode-map)
      :after clojure-mode
      :localleader
      (:prefix ("R" . "refactor")
               "?"  'cljr-describe-refactoring
               (:prefix ("a" . "add")
                        "d" 'cljr-add-declaration
                        "i" 'cljr-add-import-to-ns
                        "m" 'cljr-add-missing-libspec
                        "p" 'cljr-add-project-dependency
                        "r" 'cljr-add-require-to-ns
                        "s" 'cljr-add-stubs
                        "u" 'cljr-add-use-to-ns)
               (:prefix ("c" . "clean/cycle")
                        "c" 'cljr-cycle-coll
                        "i" 'cljr-cycle-if
                        "n" 'cljr-clean-ns
                        "p" 'cljr-cycle-privacy)
               (:prefix ("d" . "destructure")
                        "k" 'cljr-destructure-keys)
               (:prefix ("e" . "extract/expand")
                        "c" 'cljr-extract-constant
                        "d" 'cljr-extract-def
                        "f" 'cljr-extract-function
                        "l" 'cljr-expand-let)
               (:prefix ("f" . "find/fn")
                        "e" 'cljr-create-fn-from-example
                        "u" 'cljr-find-usages)
               (:prefix ("h" . "hotload")
                        "d" 'cljr-hotload-dependency)
               (:prefix ("i" . "introduce/inline")
                        "l" 'cljr-introduce-let
                        "s" 'cljr-inline-symbol)
               (:prefix ("m" . "move")
                        "f" 'cljr-move-form
                        "l" 'cljr-move-to-let)
               (:prefix ("p" . "project/promote")
                        "c" 'cljr-project-clean
                        "f" 'cljr-promote-function)
               (:prefix ("r" . "remove/rename/replace")
                        "d" 'cljr-remove-debug-fns
                        "f" 'cljr-rename-file-or-dir
                        "l" 'cljr-remove-let
                        "r" 'cljr-remove-unused-requires
                        "s" 'cljr-rename-symbol
                        "u" 'cljr-replace-use)
               (:prefix ("s" . "show/sort/stop")
                        "c" 'cljr-show-changelog
                        "n" 'cljr-sort-ns
                        "p" 'cljr-sort-project-dependencies
                        "r" 'cljr-stop-referring)
               (:prefix ("t" . "thread")
                        "f" 'cljr-thread-first-all
                        "h" 'cljr-thread
                        "l" 'cljr-thread-last-all)
               (:prefix ("u" . "unwind/update")
                        "a" 'cljr-unwind-all
                        "p" 'cljr-update-project-dependencies
                        "w" 'cljr-unwind)
               ))
