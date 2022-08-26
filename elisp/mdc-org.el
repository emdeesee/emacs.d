(require 'org)

(setq org-directory "~/Org/"
      org-startup-indented t
      org-hide-leading-stars t
      org-agenda-files (list org-directory)
      org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "PROG(p@/!)" "|" "DONE(d!)")
                          (sequence  "HOLD(h@/!)" "BLOCKED(b@/!)" "|" "CANCELLED(c!)"))
      org-todo-keyword-faces '(("TODO" . (:foreground "deep sky blue"))
                               ("PROG" . (:foreground "medium violet red" :weight bold))
                               ("DONE" . (:foreground "forest green"))
                               ("HOLD" . (:foreground "gold"))
                               ("BLOCKED" . (:foreground "red" :weight bold))
                               ("CANCELLED" . (:foreground "gray50")))
      org-agenda-custom-commands '(("n" "Personal Backlog"
                                    ((agenda "" nil)
                                     (todo "PROG")
                                     (todo "NEXT")
                                     (todo "TODO")
                                     (todo "BLOCKED"))
                                    nil)))

(add-to-list 'org-agenda-files org-directory)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-agenda-diary-file (concat org-directory "dairy.org"))

(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'flyspell-mode)

(let ((bindings '(("\C-cl" . org-store-link)
                  ("\C-ca" . org-agenda)
                  ("\C-cb" . org-iswitchb)
                  ("\C-cc" . org-capture))))
  (dolist (b bindings)
    (global-set-key (car b) (cdr b))))

(setq org-default-notes-file (concat org-directory "notes.org"))

(let ((organizer (concat org-directory "organizer.org"))
      (journal (concat org-directory "journal.org"))
      (glossary (concat org-directory "glossary.org")))
  (setq org-capture-templates
        `(("t" "Todo" entry (file+olp ,organizer "Tasks")
          "* TODO %?\n  %i\n  %a")
          ("a" "Appointment" entry (file+olp ,organizer "Events")
           "* %?\n%^T %^{Description}p %^{Location}p %^{Summary}p %^g")
          ("n" "Note" entry (file+olp+datetree ,org-default-notes-file "Notes")
           "* %?\n  %i\n  %a")
          ("j" "Journal" entry (file+olp+datetree ,journal "Journal")
           "* %?\n%U\n  %i\n  %a")
          ("i" "Idea" entry (file+olp+headline ,journal "Ideas")
           "* %^{Title}\n  %i\n %a")
          ("b" "Bookmark" entry (file+olp+headline ,journal "Bookmarks")
           "* %^{Title}\n  %U\n  %i\n %^{URL}")
          ("g" "Glossary" item (file ,glossary)
           "- %^{Term} :: %^{Definition}"))))

;; Time tracking
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(defun mdc/org-clocktable-indent-string (level)
  (if (= level 1)
      ""
    (let ((str "^"))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "--")))
      (concat str "-> "))))

(advice-add 'org-clocktable-indent-string
            :override #'mdc/org-clocktable-indent-string)

(provide 'mdc-org)
