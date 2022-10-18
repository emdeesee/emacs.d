(provide 'mdc-yaml)

(use-package yaml-mode
  :ensure t)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

