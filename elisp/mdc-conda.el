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

;; Splice environment into mode line.
(setq mode-line-conda-env
      (list 'conda-env-current-name (list "(" 'conda-env-current-name ")") "")))

(setq-default mode-line-format
              (append
               (cl-subseq mode-line-format 0 6)
               (list 'mode-line-conda-env)
               (cl-subseq mode-line-format 6)))

;; Respect HRL's CA
;; See https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/non-standard-certs.html
(setenv "REQUESTS_CA_BUNDLE" (expand-file-name "~/etc/HRLRootCABundle.pem"))

(provide 'mdc-conda)

