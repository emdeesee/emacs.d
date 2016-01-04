(setq-default magic-mode-alist '(("^From:[^\n]+\nTo:.*" . mail-mode)))


(add-hook 'mail-mode-hook (lambda ()
                            (auto-fill-mode 1)
                            (abbrev-mode 1)

                            ;; "Kill" buffer in mutt-client.
                            (local-set-key (kbd "C-c C-c") 'server-edit)))

(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(setq-default mutt-command (expand-file-name "~/bin/mutt-with-lock"))
(setq-default mutt-buffer-name "mutt")

(defun bring-the-mutt ()
  (interactive)
  (let ((buffer (get-buffer (format "*%s*" mutt-buffer-name))))
    (if buffer
        (pop-to-buffer buffer)
        (ansi-term mutt-command mutt-buffer-name))))

(global-set-key (kbd "<f9>") 'bring-the-mutt)

(defun mutt-term-exec-hook ()
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
        (when (string= event "finished\n")
          (kill-buffer ,buff))))))

(add-hook 'term-exec-hook 'mutt-term-exec-hook)

(provide 'mdc-mail)
