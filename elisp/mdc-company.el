(provide 'mdc-company)
(use-package company
  :ensure t)

(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
