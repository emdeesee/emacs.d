(require 'ido)
(ido-mode t)

(setq ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess)

(provide 'mdc-ido)