(provide 'mdc-shell)

(defun eshell/clear-buffer ()
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-emit-prompt)
    (message "cleared buffer")))

(add-hook 'eshell-mode-hook (lambda nil (local-set-key "\C-cl" 'eshell/clear-buffer)))