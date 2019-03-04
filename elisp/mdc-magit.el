(provide 'mdc-magit)
(use-package magit
  :ensure t)

;; TODO Limit keys to appropriate buffers
(defconst my/magit-prefix "\C-cg")

(setq my/magit-keymap (let ((map (make-sparse-keymap))
                            (keys `(("!" . magit-status)
                                    ("?" . magit-file-popup)
                                    ("b" . magit-blame))))
                        (dolist (k keys map)
                          (define-key map (car k) (cdr k)))))

(global-set-key my/magit-prefix my/magit-keymap)
