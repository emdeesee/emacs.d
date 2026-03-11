(use-package conda :ensure t
  :config
  (setq
   conda-anaconda-home (expand-file-name "~/hrlconda/")
   conda-env-home-directory (expand-file-name "~/.conda/"))
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell))

(defun prepend-conda-env (string)
  (if conda-env-current-name
      (concat (format "(%s) " conda-env-current-name) string)
    string))

(defun mdc/eshell-set-path (path-list)
  "Set eshell's internal conception of the search path to PATH-LIST."
  (with-connection-local-application-variables 'eshell
    (setq-connection-local eshell-path-env-list path-list)))

(mapc (lambda (sym) (advice-add sym :after
                                (lambda (&rest args) (mdc/eshell-set-path exec-path))))
      '(conda-env-activate-path conda-env-deactivate))

(with-eval-after-load 'em-prompt
  (add-function :filter-return eshell-prompt-function #'prepend-conda-env '((name . conda-env))))

;; Splice environment into mode line.
(setq mode-line-conda-env
      (list 'conda-env-current-name (list "(" 'conda-env-current-name ")") ""))

(setq-default mode-line-format
              (append
               (cl-subseq mode-line-format 0 6)
               (list 'mode-line-conda-env)
               (cl-subseq mode-line-format 6)))

(provide 'mdc-conda)

