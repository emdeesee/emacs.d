(provide 'mdc-util)
(use-package s :ensure t)
(require 'cl-format)

(defmacro my/in-directory (dir &rest body)
  "Change to directory DIR, and evaluate BODY there like `progn'."
  (declare (indent defun))
  `(let ((current-dir default-directory))
     (cd ,dir)
     (let ((result (progn ,@body)))
       (cd current-dir)
       result)))

(defun sudo-edit (&optional arg)
  (interactive "P")
  (let ((privilege "/sudo:root@localhost:"))
    (if (or arg (not buffer-file-name))
        (find-file
         (concat privilege (ido-read-file-name "File :")))
      (find-alternate-file (concat privilege (buffer-file-name))))))

(defun insert-uuid ()
  (interactive)
  (insert (s-trim (shell-command-to-string "uuidgen"))))

(defmacro ->> (&rest body)
  "Clojure's threading (thread last) operator

Evaluate the forms in order, inserting the result of the previous
form as the last argument in the current.

(->> (FOO) (BAR) (BAZ 42)) becomes (BAZ 42 (BAR (FOO)))"
  (let ((result (pop body)))
    (dolist (form body result)
      (setq result (append form (list result))))))

(defmacro -> (&rest body)
  "Clojure's threading (thread second) operator

Evaluate the forms in order, inserting the result of the previous
form as the second argument in the current.

(-> (FOO) (BAR) (BAZ 42)) becomes (BAZ (BAR (FOO)) 42)"
  (let ((result (pop body)))
    (dolist (form body result)
      (setq result (append (list (car form) result)
                           (cdr form))))))

(defun add-hooks (modes func)
  (dolist (mode modes)
    (add-hook (intern (concat (symbol-name mode) "-hook")) func)))

(defun lorem ()
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed  do "
          "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim "
          "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
          "aliquip ex ea commodo consequat. Duis aute irure dolor in "
          "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
          "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
          "culpa qui officia deserunt mollit anim id est laborum."))

(defun copy-buffer-file-name-as-kill (choice)
  "Copy the buffer file name to the kill-ring"
  (interactive "cCopy Buffer Name (F) Full, (D) Directory, (N) Name")
  (let ((new-kill-string)
	(name (if (eq major-mode 'dired-mode)
		  (dired-get-filename)
		(or (buffer-file-name) ""))))
    (cond ((eq choice ?f) (setq new-kill-string name))
	  ((eq choice ?d) (setq new-kill-string (file-name-directory name)))
	  ((eq choice ?n) (setq new-kill-string (file-name-nondirectory name)))
	  (t (message "Quit")))
    (when new-kill-string
      (message "%s copied" new-kill-string)
      (kill-new new-kill-string))))
