(provide 'mdc-lisp)
(require 'mdc-common)

(use-package clojure-mode :ensure t)
(use-package cider :ensure t)

(setq mdc-lisp-modes
      '(emacs-lisp-mode lisp-mode clojure-mode))

(defun add-lisp-hook (func)
  (add-hooks mdc-lisp-modes func))

