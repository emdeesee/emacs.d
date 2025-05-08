(provide 'mdc-git-gutter)

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (vc-mode . diff-hl-dir-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh)))
