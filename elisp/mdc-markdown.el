(provide 'mdc-markdown)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

(add-hook 'markdown-mode-hook (lambda () (visual-line-mode)))

(defun mdc/markdown-insert-anchor (id)
  (interactive "MAnchor id: ")
  (insert (concat "<a id=\"" id "\"></a>")))

