(setq user-full-name "Tim kleinschmidt"
      user-mail-address "tim.kleinschmidt@gmail.com")

(setq doom-theme 'doom-palenight)

(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :line-spacing 1.2)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono")
      doom-big-font (font-spec :family "JetBrains Mono" :size 20))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq display-line-numbers-type nil)

(add-hook 'window-setup-hook #'toggle-frame-maximized)
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))

(setq org-directory "~/Google Drive/Documents/emacs/org/"
      org-archive-location (concat org-directory ".archive/%s::")
      org-hide-emphasis-markers t
      org-startup-folded 'overview)

(setq magit-repository-directories '(("~/" . 2))
      magit-save-repository-buffers nil
      transient-values '((magit-commit "--gpg-sign=3F74D3A286A02EED")
                         (magit-rebase "--autosquash" "--gpg-sign=3F74D3A286A02EED")
                         (magit-pull "--rebase" "--gpg-sign=3F74D3A286A02EED")))

(setq cider-boot-parameters "dev --cider"
      clojure-align-forms-automatically t)

(defun clojurescript-mode-before-save-hook ()
  (interactive)
  (when (eq major-mode 'clojurescript-mode)
    (indent-region (point-min) (point-max))))

(add-hook 'before-save-hook #'clojurescript-mode-before-save-hook)

(setq-hook! 'yaml-mode-hook +format-with-lsp nil)

(add-hook 'prog-mode-hook #'rainbow-identifiers-mode)
