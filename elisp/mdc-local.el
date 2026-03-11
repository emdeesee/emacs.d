(provide 'mdc-local)

(setq visible-bell 1
      initial-scratch-message ""
      inhibit-startup-message t
      inhibit-startup-echo-area-message "mdcornelius")


;;; use hunspell as flyspell backend

(defun mdc/-configure-ispell ()
  (setenv "DICPATH" (expand-file-name "~/Dictionaries/"))
  (setenv "LANG" "en_US.UTF-8")
  (setq ispell-program-name "hunspell"
        ispell-hunspell-dict-paths-alist `(("en_US" ,(expand-file-name "~/Dictionaries/en_US.aff")))
        ispell-local-dictionary "en_US"
        ispell-local-dictionary-alist '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))

(defun mdc/-system-type-config ()
  (cond
   ((eq system-type 'windows-nt)
    (setq mdc/*inferior-lisp-program* "c:/users/mdcornelius/AppData/Local/hrlconda/Library/bin/sbcl.exe")
    (setq magit-git-executable "c:/Program Files/Git/bin/git.exe")
    (setq find-program "c:/msys64/usr/bin/find.exe") ; fix find-dired on windows

    ;; Put unix-impersonation tools at the end of PATH to
    ;; specifically not get in the way of the native openssl
    ;; installation.
    (setenv "PATH"
            (concat
             (getenv "PATH")
             (cl-format nil ";~{~a~^;~}"
                        '("c:/msys64/mingw64/bin"
                          "c:/Program Files/Git/bin"
                          "c:/msys64/usr/bin/"))))
    (add-to-list 'exec-path "c:/Program Files/Git/bin" 'append)
    (add-to-list 'exec-path "c:/msys64/usr/bin/" 'append)
    (add-to-list 'exec-path "c:/msys64/mingw64/bin/" 'append)

    (mdc/-configure-ispell))

   ((eq system-type 'darwin)
    (setq ispell-program-name "aspell")
    (setq dired-use-ls-dired nil)
    (eval-after-load "flyspell"
      '(progn
         (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
         (define-key flyspell-mouse-map [mouse-3] #'undefined))))))

(defun mdc/-environment-config ()
  (with-eval-after-load 'gnutls
    (add-to-list 'gnutls-trustfiles (expand-file-name "~/etc/HRLCABundle.pem")))

  (dolist (env-data
           '(("GITLAB_PRIVATE_TOKEN" . "~/.gltok")
             ("RT_ACCESS_TOKEN" . "~/.jftok")))
    (setenv-from-file (car env-data) (expand-file-name (cdr env-data)))))

(defun mdc/apply-local-config ()
  (mdc/-system-type-config)
  (mdc/-environment-config))

(mdc/apply-local-config)

(defun mdc/correct-horse ()
  (interactive)
  (let ((tmp-buffer (generate-new-buffer (make-temp-name "*correct-horse-tmp*"))))
    (with-current-buffer tmp-buffer
      ;; Populate buffer.
      (insert-file "/usr/share/dict/words")
      (beginning-of-buffer)
      (delete-matching-lines "^[A-Z]")

      ;; Select words.
      (let ((lines (count-lines (point-min) (point-max))))
        (dotimes (n 4)
          (goto-line (random lines))
          (beginning-of-line)
          (while (looking-at "^\\*")
            (forward-line 1)
            (beginning-of-line))
          (insert "*")))

      ;; Post-process buffer to produce passphrase.
      (beginning-of-buffer)
      (delete-non-matching-lines "^\\*")
      (replace-regexp "^\\*" "")
      (beginning-of-buffer)
      (while (re-search-forward "
" nil t)
        (replace-match " " nil ))
      (goto-char (point-max))
      (delete-char -1)
      (kill-region (point-min) (point-max)))
    (kill-buffer tmp-buffer))

  ;; Show the result
  (let ((display-buffer (get-buffer-create "*correct-horse*")))
    (with-current-buffer display-buffer
      (goto-char (point-max))
      (if (not (looking-at "^$"))
          (newline))
      (yank)
      (display-buffer-same-window display-buffer nil))))
