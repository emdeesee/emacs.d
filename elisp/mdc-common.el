(provide 'mdc-common)

(setq mdc/*rage* '(("_" . "ಠ_ಠ") ("?" . "¯\\_(ツ)_/¯") ("!" . "(╯°□°)╯︵ ┻━┻")))
(defmacro rage! (which) `(lambda () (interactive) (insert ,(cdr (assoc which mdc/*rage*)))))
(global-set-key (kbd "C-c f _") (rage! "_"))
(global-set-key (kbd "C-c f ?") (rage! "?"))
(global-set-key (kbd "C-c f !") (rage! "!"))

(use-package tron-legacy-theme
  :ensure t
  :config
  (setq tron-legacy-theme-vivid-cursor t)
  (load-theme 'tron-legacy t))

;; WSL handling

(when (mdc/running-in-wsl-p)
  (message "Running in WSL -- Applying WSL-specific settings...")
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program
        (or (executable-find "wslview")
            "/mnt/c/Program Files/Mozilla Firefox/firefox.exe")))


(with-eval-after-load 'org
    (setq org-link-frame-setup
          '((vm . vm-visit-folder)
            (vm-imap . vm-visit-imap-folder)
            (gnus . org-gnus-follow-link)
            (file . find-file)
            (wl . wl-draft)
            (mailto . browse-url)
            (news . browse-url)
            (http . browse-url)
            (https . browse-url)
            (ftp . browse-url)
            (help . org-help-follow-link)
            (man . org-man-follow-link)
            (elisp . org-elisp-follow-link))))
