(provide 'mdc-smartparens)
(require 'mdc-lisp)

(use-package smartparens
  :config
  (progn
    (use-package smartparens-config)
    (smartparens-global-mode t)
    (show-smartparens-global-mode t)
    (add-lisp-hook 'smartparens-strict-mode)
    (setq-default sp-hybrid-kill-excessive-whitespace t)

    (define-key sp-keymap (kbd "<delete>") 'sp-delete-char)
    (define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
    (define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)
    (define-key sp-keymap (kbd "C-S-<right>") 'sp-backward-barf-sexp)
    (define-key sp-keymap (kbd "C-S-<left>") 'sp-backward-slurp-sexp)
    (define-key sp-keymap (kbd "M-s") 'sp-unwrap-sexp)
    (define-key sp-keymap (kbd "M-S-s") 'sp-raise-sexp)
    (define-key sp-keymap (kbd "M-p") 'sp-split-sexp)
    (define-key sp-keymap (kbd "M-S-p") 'sp-join-sexp)
    (define-key sp-keymap (kbd "M-t") 'sp-transpose-sexp)))
