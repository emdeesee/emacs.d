(provide 'mdc-git-gutter)

(use-package git-gutter
  :ensure t

  :init (progn
          
          ;; Make prefix map for git-gutter commands
          (setq git-gutter-submap (make-sparse-keymap))

          ;; Jump between hunks
          (define-key git-gutter-submap (kbd "n") 'git-gutter:next-hunk)
          (define-key git-gutter-submap (kbd "p") 'git-gutter:previous-hunk)

          ;; Act on hunks
          (define-key git-gutter-submap (kbd "v =") 'git-gutter:popup-hunk)
          (define-key git-gutter-submap (kbd "r") 'git-gutter:revert-hunk)

          ;; Stage hunk at point.
          ;; If region is active, stage all hunk lines within the region.
          (define-key git-gutter-submap (kbd "t") 'git-gutter:stage-hunk))

  :config (progn
            (global-git-gutter-mode 1)))


; (define-key git-gutter-mode-map (kbd "C-x g") git-gutter-submap)
