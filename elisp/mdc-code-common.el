(provide 'mdc-code-common)
(require 'mdc-common)
(require 'mdc-lisp)
(use-package highlight-current-line
  :ensure t)

(highlight-current-line-set-bg-color "aliceblue")

(defun common-coding-config ()
  (setq-local whitespace-style '(face trailing tabs))
  (highlight-current-line-minor-mode 1)
  (whitespace-mode 1))

(let ((coding-modes '(c-mode-common
                      python-mode
                      tcl-mode)))
  (add-hooks coding-modes 'common-coding-config))

(add-lisp-hook 'common-coding-config)
