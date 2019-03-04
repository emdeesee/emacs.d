(provide 'mdc-common)

(setq mdc/*rage* '(("_" . "ಠ_ಠ") ("?" . "¯\\_(ツ)_/¯") ("!" . "(╯°□°)╯︵ ┻━┻")))
(defmacro rage! (which) `(lambda () (interactive) (insert ,(cdr (assoc which mdc/*rage*)))))
(global-set-key (kbd "C-c f _") (rage! "_"))
(global-set-key (kbd "C-c f ?") (rage! "?"))
(global-set-key (kbd "C-c f !") (rage! "!"))

