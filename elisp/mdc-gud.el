(provide 'mdc-gud)

;; company does not play well with gdb
(add-hook 'gud-mode-hook (lambda () (interactive) (company-mode -1)))
