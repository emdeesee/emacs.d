(provide 'mdc-jinja2)

(use-package jinja2-mode
  :ensure t
  :mode ("\\.j2\\'" "\\.jinja2\\'") ; Automatically activate for these file extensions
  :config
  ;; Optional: Add any custom configuration here
  (add-to-list 'auto-mode-alist '("\\.html\\'" . jinja2-mode)) ;; Use for .html files too
)
