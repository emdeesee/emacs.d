(provide 'mdc-lisp)
(require 'mdc-common)
(require 'mdc-local nil :noerror)

(use-package clojure-mode :ensure t)
(use-package cider :ensure t)
(use-package slime
  :ensure t
  :config (progn
            (setq inferior-lisp-program
                  (if (fboundp 'mdc/*inferior-lisp-program*)
                      mdc/*inferior-lisp-program*
                    "/usr/bin/sbcl"))
            (slime-setup '(slime-fancy slime-asdf))))

(setq mdc-lisp-modes
      '(emacs-lisp-mode lisp-mode clojure-mode))

(defun add-lisp-hook (func)
  (add-hooks mdc-lisp-modes func))

