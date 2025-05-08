(provide 'mdc-elfeed)

(use-package elfeed)

(let ((feeds-file (expand-file-name "elfeed-feeds.el" (or (getenv "XDG_CONFIG_HOME")
                                                          "~/.local"))))
  (when (file-exists-p feeds-file)
    (load-file feeds-file)))

(setq-default elfeed-search-filter "@2-weeks-ago +unread +frontpage")
