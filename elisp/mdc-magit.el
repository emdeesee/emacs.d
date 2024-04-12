(add-to-list 'load-path "~/lib/emacs/site-lisp/magit/lisp")
(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/lib/emacs/site-lisp/magit/Documentation/"))

;; TODO Limit keys to appropriate buffers
(defconst mdc/magit-prefix "\C-cg")

(setq mdc/magit-keymap (let ((map (make-sparse-keymap))
                            (keys `(("!" . magit-status)
                                    ("?" . magit-file-popup)
                                    ("b" . magit-blame)
                                    ("g" . mdc/git-grep))))
                        (dolist (k keys map)
                          (define-key map (car k) (cdr k)))))

(global-set-key mdc/magit-prefix mdc/magit-keymap)

(provide 'mdc-magit)
