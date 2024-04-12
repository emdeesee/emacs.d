;; -*- lexical-binding: t; -*-


(let ((b3x-path (expand-file-name "~/src/bov3xfer/")))
  (use-package bov3xfer
    :load-path b3x-path
    :config
    (setq bov3xfer-first-name "Michael")
    (setq bov3xfer-last-name "Cornelius")
    (setq bov3xfer-classification-level "U")))

(setq-default runner-status-gitlab-url "https://hrl-gitlab.hrl.com")
(setq-default runner-status-endpoint "/api/v4/runners")
(setq-default runner-status-buffer (format "*runner status: %s*" runner-status-gitlab-url))
(setq-default runner-status-cache-file (expand-file-name "~/.runner-status-cache.txt"))

;; (setenv-from-file "GITLAB_PRIVATE_TOKEN" (expand-file-name "~/.gltok"))

;;;###autoload
(defun runner-status-load (buffer data)
  (with-current-buffer buffer
    (erase-buffer)
    (cl-loop for record across data
             do (cl-flet ((lookup (field)
                                  (cdr (assoc field record))))
                  (insert
                   (format "%-8s %4d %s\n"
                           (lookup 'status)
                           (lookup 'id)
                           (lookup 'description)))))
    (sort-lines nil (point-min) (point-max))))

;;;###autoload
(cl-defun runner-status-display-status (&key data &allow-other-keys)
  (let ((buffer (get-buffer-create runner-status-buffer)))
    (runner-status-load buffer data)
    (pop-to-buffer buffer)))

;; TODO record benchmark.
;; See `ediff-cleanup-hook'
;;;###autoload
(cl-defun runner-status-track-status (&key data &allow-other-keys)
  (let ((cached "*runner-status: cached*")
        (current "*runner-status: current*"))
    (runner-status-load (get-buffer-create current) data)
    (if (file-exists-p runner-status-cache-file)
        (with-current-buffer (get-buffer-create cached)
          (insert-file-contents runner-status-cache-file :visit nil nil :replace)
          (ediff-buffers cached current))
      (message "No existing data to compare."))))

;;;###autoload
(defun get-runner-status (callback)
  (request (format "%s%s" runner-status-gitlab-url runner-status-endpoint)
    :headers (list (cons "Authorization" (format "Bearer %s" (getenv "GITLAB_PRIVATE_TOKEN"))))
    :params '(("pagination" . "keyset")
              ("per_page" . "100"))
    :parser 'json-read
    :success callback
    :error (cl-function
            (lambda (&rest args &key error-thrown &allow-other-keys)
              (message "All did not go as planned: %S" error-thrown)))))

;;;###autoload
(defun runner-status ()
  (interactive)
  (get-runner-status #'runner-status-display-status))
