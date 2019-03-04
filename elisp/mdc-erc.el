(require 'erc)

(require 'erc-truncate)
(require 'mdc-common)
(require 's)

(add-to-list 'erc-modules 'notifications)
(setq erc-notifications-icon
      "/usr/share/icons/Tango/scalable/apps/internet-group-chat.svg")

(setq erc-lurker-hide-list '("JOIN" "PART" "QUIT")
      erc-lurker-hide-threshold 3600)

(setq erc-prompt (lambda () (concat (buffer-name) " <")))

(add-hook 'erc-mode-hook
          (lambda ()
            (make-local-variable 'ffap-file-finder)
            (setq ffap-file-finder #'find-file-other-frame)))

(provide 'mdc-erc)
