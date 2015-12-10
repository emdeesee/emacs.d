(require 'ido)
(ido-mode t)

(setq ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-default-buffer-method 'maybe-frame)

(provide 'mdc-ido)
