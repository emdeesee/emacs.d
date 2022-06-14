(provide 'mdc-git)
(use-package cl-format :ensure t)

(defun mdc/git-repo-root ()
  (with-temp-buffer
    (let ((result
           (call-process "git" nil (current-buffer) nil "rev-parse" "--show-toplevel")))
      (values (if (zerop result) t nil) (s-trim (buffer-string))))))

(autoload 'grep-read-regexp "grep")

(setq mdc/*git-grep-command-fmt* "git --no-pager grep -nH -E \"~a\" -- ~a")

(defun mdc/-git-grep-command (regexp pathspec)
  (cl-format nil mdc/*git-grep-command-fmt* regexp (or pathspec "")))

(defun mdc/git-grep (regexp &optional pathspec)
  "Use git grep to search current git repository for REGEXP.

With \\[universal-argument] prefix, you will be prompted for a
PATHSPEC to limit the search."
  (interactive
   (progn
     (let ((regexp (grep-read-regexp))
           (pathspec (when current-prefix-arg
                       (read-string "Pathspec: "))))
       (list regexp pathspec))))
  (let ((git-root (mdc/git-repo-root)))
    (if (not (car git-root))
        (message "%s: not a git repo" (default-dir))
      (in-directory (cadr git-root)
        (compile (mdc/-git-grep-command regexp pathspec))))))

