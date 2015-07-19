;; disable bothersome UI elements
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

(setq inhibit-splash-screen t)

;; prefer y/n keypress to typing 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; prefer backward-kill-word to backspace
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-z") 'eshell)

(global-unset-key (kbd "C-z"))

(setq config-dir (file-name-directory
                  (or (buffer-file-name) load-file-name)))

;; add all subdirectories of ~/.emacs.d/site-lisp to load path
(let ((site-lisp (concat config-dir "site-lisp")))
  (when (file-exists-p site-lisp)
    (dolist
	(f (directory-files site-lisp t "\\w+"))
      (when (file-directory-p f)
	(add-to-list 'load-path f)))))

(add-to-list 'load-path (concat config-dir "preferences"))

;; Set paths to custom.el and loaddefs.el
(setq autoload-file (concat config-dir "loaddefs.el"))
(setq custom-file (concat config-dir "custom.el"))

;; Configure and initialize package.el
(setq package-user-dir (concat config-dir "packages"))
(require 'package)
(dolist (package-source '(("melpa-stable" . "http://stable.melpa.org/packages/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")))
  (add-to-list 'package-archives package-source 'append))

(package-initialize)
(unless (file-exists-p package-user-dir)
  (package-refresh-contents))

(defun require-package (package)
  (when (and (not (package-installed-p package))
		  (y-or-n-p (format"%s: package missing. Install?" package)))
    (package-install package)))

(let ((required '(s
		  clojure-mode
		  smartparens)))
  (mapc #'require-package required))

;; Load personal customizations and things.
(let ((libs '(mdc-common
	      mdc-lisp
	      mdc-smartparens
	      mdc-ido)))
  (mapc #'require libs))

(when (file-exists-p custom-file)
  (load custom-file))
