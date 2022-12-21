(use-package conda :ensure t
  :config
  (setq
   conda-anaconda-home (expand-file-name "~/opt/hrlconda/")
   conda-env-home-directory (expand-file-name "~/.conda/"))
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell))

(defun prepend-conda-env (string)
  (if conda-env-current-name
      (concat (format "(%s) " conda-env-current-name) string)
    string))

(with-eval-after-load 'em-prompt
  (add-function :filter-return eshell-prompt-function #'prepend-conda-env '((name . conda-env)))

(provide 'mdc-conda)
