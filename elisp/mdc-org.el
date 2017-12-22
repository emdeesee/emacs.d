(require 'org)

(setq org-directory "~/Org/"
      org-startup-indented t
      org-hide-leading-stars t
      org-agenda-files (list org-directory)
      org-todo-keywords '((sequence "TODO" "BLOCKED" "|" "DONE")))

(add-to-list 'org-agenda-files org-directory)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-agenda-diary-file "~/Org/diary.org")

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
      (journal (concat org-directory "journal.org")))
  (setq org-capture-templates
        `(("t" "Todo" entry (file+headline ,organizer "Tasks")
          "* TODO %?\n  %i\n  %a")
          ("a" "Appointment" entry (file+headline ,organizer "Events")
           "* %?\n%^T %^{Description}p %^{Location}p %^{Summary}p %^g")
          ("n" "Note" entry (file+datetree ,org-default-notes-file)
           "* %?\n  %i\n  %a")
          ("j" "Journal" entry (file+datetree ,journal)
           "* %?\n%U\n  %i\n  %a")
          ("i" "Idea" entry (file+headline ,journal "Ideas")
           "* %^{Title}\n  %i\n %a")
          ("b" "Bookmark" entry (file+headline ,journal "Bookmarks")
           "* %^{Title}\n  %U\n  %i\n %^{URL}"))))

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
