(require 'org)

(use-package org-bullets
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-+]\\) *[^ ]"
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(defconst mdc/org-directory
  (let ((dir (getenv "ORG_DIR")))
    (unless dir
      (display-warning
       'mdc-config
       "Environment variable ORG_DIR is not set. Falling back to ~/Org/"
       :warning)
      (setq dir "~/Org/"))
    (file-name-as-directory (expand-file-name dir))))

(unless (file-directory-p mdc/org-directory)
  (display-warning
   'mdc-config
   (format "ORG_DIR directory does not exist: %s" mdc/org-directory)
   :warning))

(setq org-directory mdc/org-directory
      org-startup-indented t
      org-hide-leading-stars t
      org-log-done 'time
      org-hide-emphasis-markers t
      org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "PROG(p@/!)" "|" "DONE(d!)")
                          (sequence  "HOLD(h@/!)" "BLOCKED(b@/!)" "TRACK" "|" "CANCELED(c!)")
                          (sequence "MEET" "MET" "|" "CANCELED" "NOSHOW"))
      org-todo-keyword-faces '(("TODO" . (:foreground "deep sky blue"))
                               ("PROG" . (:foreground "medium violet red" :weight bold))
                               ("DONE" . (:foreground "forest green"))
                               ("TRACK" . (:foreground "medium orchid"))
                               ("HOLD" . (:foreground "goldenrod"))
                               ("BLOCKED" . (:foreground "red" :weight bold))
                               ("MEET" . (:foreground "aqua"))
                               ("MET" . (:foreground "forest green"))
                               ("TRACK" . (:foreground "light steel blue"))
                               ("NOSHOW" . (:foreground "orange red"))
                               ("CANCELED" . (:foreground "gray50")))
      org-agenda-custom-commands '(("n" "Personal Backlog"
                                    ((agenda "" nil)
                                     (todo "PROG")
                                     (todo "NEXT")
                                     (tags-todo "-daily/+TODO")
                                     (todo "TRACK|HOLD")
                                     (todo "BLOCKED"))
                                    nil)
                                   ("w" "Recently Completed"
                                    tags
                                    "TODO=\"DONE\"&CLOSED>=\"<-7d>\""
                                    ((org-agenda-overriding-header "DONE items closed in the last seven days")
                                     (org-agenda-sorting-strategy '(timestamp-down priority-down))))))


(add-to-list 'org-agenda-files org-directory)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-agenda-diary-file (concat org-directory "dairy.org"))

(add-hook 'org-mode-hook (lambda ()
                           (interactive)
                           (flyspell-mode 1)
                           (visual-line-mode 1)))

(let ((bindings '(("\C-cl" . org-store-link)
                  ("\C-ca" . org-agenda)
                  ("\C-cb" . org-iswitchb)
                  ("\C-cc" . org-capture))))
  (dolist (b bindings)
    (global-set-key (car b) (cdr b))))

(setq org-default-notes-file (concat org-directory "notes.org"))

(let ((organizer (concat org-directory "organizer.org"))
      (journal (concat org-directory "journal.org"))
      (glossary (concat org-directory "glossary.org"))
      (phone-interview-target (expand-file-name "~/tmp/phone-interview-invitation.org"))
      (phone-interview-template (expand-file-name "~/Documents/phone-screen-template.txt"))
      (coding-exercise-target (expand-file-name "~/tmp/coding-exercise-invitation.org"))
      (coding-exercise-template (expand-file-name "~/Documents/coding-exercise-template.txt"))
      (ref-check-target (expand-file-name "~/tmp/ref-check-outreach-email.org"))
      (ref-check-template (expand-file-name "~/Documents/ref-check-outreach-template.txt")))
  (setq org-capture-templates
        `(("t" "Todo" entry (file+olp ,organizer "Tasks")
          "* TODO %?\n  %i\n  %a")
          ("a" "Appointment" entry (file+headline ,organizer "Events")
           "* MEET %^{Description}	%^g\nSCHEDULED: %^T %^{Location}p %^{PoC}p")
          ("n" "Note" entry (file+olp+datetree ,org-default-notes-file "Notes")
           "* %?\n  %i\n  %a")
          ("j" "Journal" entry (file+olp+datetree ,journal "Journal")
           "* %?\n%U\n  %i\n  %a")
          ("i" "Idea" entry (file+olp+headline ,journal "Ideas")
           "* %^{Title}\n  %i\n %a")
          ("b" "Bookmark" entry (file+olp+headline ,journal "Bookmarks")
           "* %^{Title}\n  %U\n  %i\n %^{URL}")
          ("g" "Glossary" item (file ,glossary)
           "- %^{Term} :: %^{Definition}")
          ("p" "Phone Interview Email" plain
           (file ,phone-interview-target)
           (file ,phone-interview-template)
           :prepend t :jump-to-captured t :empty-after 2)
          ("x" "Practical Exercise Email" plain
           (file ,coding-exercise-target)
           (file ,coding-exercise-template)
           :prepend t :jump-to-captured t :empty-after 2)
          ("r" "Reference Check Outreach" plain
           (file ,ref-check-target)
           (file ,ref-check-template)
           :prepend t :jump-to-captured t :empty-after 2))))

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

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (lisp . t)
   (shell . t)))

(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.2))

(provide 'mdc-org)
