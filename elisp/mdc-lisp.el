(provide 'mdc-lisp)
(require 'mdc-common)
(require 'mdc-local nil :noerror)

(use-package clojure-mode :ensure t)
(use-package cider :ensure t)
(use-package slime
  :ensure t
  :config (progn
            (setq inferior-lisp-program
                  (if (boundp 'mdc/*inferior-lisp-program*)
                      mdc/*inferior-lisp-program*
                    "/usr/bin/sbcl"))
            (slime-setup '(slime-fancy slime-asdf))))
(use-package rainbow-delimiters :ensure t)

(setq mdc-lisp-modes
      '(emacs-lisp-mode lisp-mode clojure-mode))

(defun add-lisp-hook (func)
  (add-hooks mdc-lisp-modes func))

(add-lisp-hook (lambda ()
                 (rainbow-delimiters-mode)))
