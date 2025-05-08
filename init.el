;; disable bothersome UI elements
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode blink-cursor-mode))
  (when (fboundp mode) (funcall mode -1)))

;; We're not using package; we're using straight.el.
(setq package-enable-at-startup nil)

(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode nil)

;; prefer y/n keypress to typing 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; prefer backward-kill-word to backspace
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-z") 'eshell)

(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-z"))

(setq config-dir (file-name-directory
                  (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path (concat config-dir "elisp"))

;; add all subdirectories of ~/.emacs.d/elisp to load path
(let ((site-lisp (concat config-dir "elisp")))
  (when (file-exists-p site-lisp)
    (dolist
	(f (directory-files site-lisp t "\\w+"))
      (when (file-directory-p f)
	(add-to-list 'load-path f)))))

;; Create a directory outside source control for external packages, etc.
(setq external-config-dir (expand-file-name "~/lib/emacs/"))
(when (not (file-directory-p external-config-dir))
  (make-directory external-config-dir :parents))

;; Set paths to custom.el and loaddefs.el
(setq autoload-file (concat external-config-dir "loaddefs.el"))
(setq custom-file (concat external-config-dir "custom.el"))

;; ---- Bootstrap straight.el ----
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; ---- Install and configure use-package via straight ----
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Load personal customizations and things.
(let ((libs '(mdc-util
              mdc-common
              mdc-git
	      mdc-lisp
	      mdc-company
	      mdc-multiple-cursors
	      mdc-magit
              mdc-git-gutter
	      mdc-smartparens
	      mdc-ido
              mdc-code-common
              mdc-mail
              mdc-org
              mdc-shell
              mdc-erc
              mdc-gud
              mdc-markdown
              mdc-yaml)))
  (mapc #'require libs))

(require 'mdc-local nil :noerror)
(load custom-file :noerror)

(put 'erase-buffer 'disabled nil)
