(provide 'mdc-git-gutter)

(use-package git-gutter+
  :ensure t

  :init (progn
          
          ;; Make prefix map for git-gutter commands
          (setq git-gutter-submap (make-sparse-keymap))

          ;; Jump between hunks
          (define-key git-gutter-submap (kbd "n") 'git-gutter+-next-hunk)
          (define-key git-gutter-submap (kbd "p") 'git-gutter+-previous-hunk)

          ;; Act on hunks
          (define-key git-gutter-submap (kbd "v =") 'git-gutter+-show-hunk)
          (define-key git-gutter-submap (kbd "r") 'git-gutter+-revert-hunk)

          ;; Stage hunk at point.
          ;; If region is active, stage all hunk lines within the region.
          (define-key git-gutter-submap (kbd "t") 'git-gutter+-stage-hunks)
          (define-key git-gutter-submap (kbd "c") 'git-gutter+-commit)
          (define-key git-gutter-submap (kbd "C") 'git-gutter+-stage-and-commit)
          (define-key git-gutter-submap (kbd "C-y") 'git-gutter+-stage-and-commit-whole-buffer)
          (define-key git-gutter-submap (kbd "U") 'git-gutter+-unstage-whole-buffer))

  :config (progn
            (define-key git-gutter+-mode-map (kbd "C-x g") git-gutter-submap)
            (global-git-gutter+-mode 1)))
