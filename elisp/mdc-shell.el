(provide 'mdc-shell)

(setq eshell-visual-subcommands
      '(("conda" "install" "create" "env" "update")
        ("git" "log" "diff" "show")
        ("docker" "pull")))

(defun eshell/clear-buffer ()
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-emit-prompt)
    (message "cleared buffer")))

(add-hook 'eshell-mode-hook (lambda nil (local-set-key "\C-cl" 'eshell/clear-buffer)))
