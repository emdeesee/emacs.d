(require 'erc)

(require 'erc-truncate)
(require 'mdc-common)
(require 's)

(defvar mdc/erc-notifications-buffer-name "*erc-notifications*")

(defun mdc/erc-setup-notifications-log-buffer ()
  (save-excursion
    (let ((buffer (get-buffer-create mdc/erc-notifications-buffer-name)))
      (set-buffer buffer)
      (read-only-mode 1)
      (bury-buffer)
      buffer)))

(defun mdc/erc-get-notifications-log-buffer ()
  (let ((buffer (get-buffer mdc/erc-notifications-buffer-name)))
    (or buffer
        (mdc/erc-setup-notifications-log-buffer))))

(defun mdc/erc-log-notification (message)
  (save-excursion
    (set-buffer (mdc/erc-get-notifications-log-buffer))
    (let ((inhibit-read-only t))
      (goto-char (point-max))
      (insert (concat (format-time-string "%c") " " message))
      (newline))))

(defun mdc/erc-extract-nick (nickuserhost)
  (first (s-split "!" nickuserhost)))

(defun mdc/erc-notify (summary message)
  (mdc/play-sound "~/Media/erc-beep.ogg")
  (mdc/notify summary message "dialog-information")
  (mdc/erc-log-notification (concat summary " " message)))

(defun mdc/erc-mention-notify (match-type nickuserhost message)
  (when (eq match-type 'current-nick)
    (let* ((sender (mdc/erc-extract-nick nickuserhost))
           (summary (concat sender " says:"))
           (message (s-truncate 48 (s-trim (s-chop-prefix
                                            (concat (erc-compute-nick) ":")
                                            message)))))
      (mdc/erc-notify summary message))))

(add-hook 'erc-text-matched-hook 'mdc/erc-mention-notify)

(defun mdc/erc-privmsg-notify (proc parsed)
  (let* ((target (car (erc-response.command-args parsed)))
         (for-me (erc-current-nick-p target))
         (sender (mdc/erc-extract-nick (erc-response.sender parsed)))
         (summary (concat "Private message from " sender))
         (message (s-truncate 64 (erc-response.contents parsed))))
    (when for-me
      (mdc/erc-notify summary message)))
  nil)

(add-hook 'erc-server-PRIVMSG-functions 'mdc/erc-privmsg-notify)

(setq erc-prompt (lambda () (concat (buffer-name) " <")))

(add-hook 'erc-mode-hook
          (lambda ()
            (make-local-variable 'ffap-file-finder)
            (setq ffap-file-finder #'find-file-other-frame)))

(provide 'mdc-erc)
