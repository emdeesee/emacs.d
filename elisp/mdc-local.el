(provide 'mdc-local)

;;; HRL Timekeeping

;; TODO Further timekeeping efficiencies.

(setq mdc/timelog-path-name (expand-file-name "~/Documents/timelog.org")
      mdc/timelog-charge-codes '("B1AB Kessel Software Support and DevOps"
                                 "WA00 Non Project Labor"))


(defun mdc/timelog ()
  (interactive)
  (let ((timelog-buffer (get-buffer (file-name-nondirectory mdc/timelog-path-name))))
    (if timelog-buffer
        (switch-to-buffer timelog-buffer)
      (find-file mdc/timelog-path-name))))


; Open timelog on startup
(mdc/timelog)


(defun mdc/org-clocktable-min-to-frac (min)
  (/ (round (/ min 6.0)) 10.0))


(defun mdc/org-clocktable-to-decimal-hours (time-value)
  "HRL wants time reported in decimal hours. Convert a string with
the format HH:MM to a decimal value of hours."
  (if (zerop (length time-value))
      ""
    (let ((values (split-string time-value ":")))
      (when (= (length values) 2)
        (let ((hours (string-to-number (car values)))
              (minutes (string-to-number (cadr values))))
          (+ hours (mdc/org-clocktable-min-to-frac minutes)))))))


;;; Experimental: https://bzg.fr/en/emacs-strip-tease/
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

;;; Conda (WIP)
(use-package conda :ensure t
  :config
  (setq conda-env-home-directory (expand-file-name "~/appdata/Local/hrlconda"))
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell))


;;; system-type specific stuff.
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
  (setq ispell-program-name "aspell")))
