(provide 'mdc-elfeed)

(use-package elfeed)

(defvar mdc/elfeed-feeds-file
  (expand-file-name "elfeed-feeds.el" (or (getenv "XDG_CONFIG_HOME") "~/.local")))

(when (file-exists-p mdc/elfeed-feeds-file)
  (load-file mdc/elfeed-feeds-file))

(defun mdc/reload-elfeed-feeds (_event)
  "Reload elfeed-feeds from file when it changes."
  (message "Reloading elfeed feeds from %s..." mdc/elfeed-feeds-file)
  (load-file mdc/elfeed-feeds-file)
  (when (get-buffer "*elfeed-search*")
    (with-current-buffer "*elfeed-search*"
      (elfeed-search-update--force)))
  (message "Feeds reloaded."))

(when (and (file-exists-p mdc/elfeed-feeds-file)
           (require 'filenotify nil t))
  (file-notify-add-watch mdc/elfeed-feeds-file
                         '(change)
                         #'mdc/reload-elfeed-feeds))

(setq-default elfeed-search-filter "@2-weeks-ago +unread +frontpage")
