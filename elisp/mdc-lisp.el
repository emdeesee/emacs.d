(require 'mdc-common)

(require 'clojure-mode)

(setq mdc-lisp-modes
      '(emacs-lisp-mode lisp-mode clojure-mode))

(defun add-lisp-hook (func)
  (add-hooks mdc-lisp-modes func))

(provide 'mdc-lisp)
