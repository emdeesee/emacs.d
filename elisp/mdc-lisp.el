(provide 'mdc-lisp)
(require 'mdc-common)
(require 'mdc-local nil :noerror)

(use-package slime
  :config (progn
            (setq inferior-lisp-program
                  (if (boundp 'mdc/*inferior-lisp-program*)
                      mdc/*inferior-lisp-program*
                    "/usr/bin/sbcl"))
            (slime-setup '(slime-fancy slime-asdf))))
(use-package rainbow-delimiters)

(setq mdc-lisp-modes
      '(emacs-lisp-mode lisp-mode clojure-mode))

(defun add-lisp-hook (func)
  (add-hooks mdc-lisp-modes func))

(add-lisp-hook (lambda ()
                 (rainbow-delimiters-mode)))
