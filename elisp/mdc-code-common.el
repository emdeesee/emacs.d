(provide 'mdc-code-common)
(require 'mdc-common)
(require 'mdc-lisp)

(defun common-coding-config ()
  (setq-local whitespace-style '(face trailing tabs))
  (hl-line-mode 1)
  (whitespace-mode 1)
  (display-line-numbers-mode 1))

(let ((coding-modes '(c-mode-common
                      python-mode
                      tcl-mode)))
  (add-hooks coding-modes 'common-coding-config))

(add-lisp-hook 'common-coding-config)
