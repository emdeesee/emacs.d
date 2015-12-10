(defun sudo-edit (&optional arg)
  (interactive "P")
  (let ((privilege "/sudo:root@localhost:"))
    (if (or arg (not buffer-file-name))
        (find-file
         (concat privilege (ido-read-file-name "File :")))
      (find-alternate-file (concat privilege (buffer-file-name))))))

(require 's)

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

(provide 'mdc-common)