(general-create-definer org-leader-definer
  :states '(normal motion visual)
  :wrapping global-definer
  :prefix "SPC o"
  "" '(:ignore t :which-key "mode"))


(use-package org
  :config
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-span 7)
  (setq org-agenda-start-on-weekday nil)
  (setq org-agenda-files (directory-files-recursively "~/docs/agenda/" "\\.org$"))
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-ellipsis "..."
        org-hide-emphasis-markers t
        org-hide-leading-stars t
        org-agenda-files (append
                          (file-expand-wildcards "~/notes/*.org")))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)


  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "LEARN(l)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-tag-alist
      '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))



  :hook (org-mode . org-indent-mode)
  :general
  (org-leader-definer
    :keymaps 'org-mode-map
    "t" '(org-todo :wk "Org todo")
    "T" '(counsel-org-tag :wk "Org todo list")
    "m" '(org-modern-mode :wk "Toggle org modern mode")
    "p" '(org-set-property :wk "Toggle set property")
    "t" '(org-todo :wk "Org todo")))


  ;; Configure custom agenda views
(setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))


    ("p" "Planned Tasks"
     ((todo "PLAN"
        ((org-agenda-overriding-header "Planned Tasks")))))


    ("l" "Learn Tasks"
     ((todo "LEARN"
        ((org-agenda-overriding-header "Learn Tasks")))))

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))


(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  ;; :custom
  ;; (org-bullets-bullet-list '("H1" "H2" "H3" "H4" "H5" "H6" "H7"))
  )

(use-package org-modern)
(add-hook 'org-mode-hook #'org-modern-mode)
(setq org-modern-block-fringe nil)
(setq org-modern-star nil)

(use-package evil-org
  :straight t
  :after org
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  :hook (org-mode . (lambda () evil-org-mode)))

(add-hook 'org-mode-hook #'evil-org-mode)





(provide 'lang/org)
;;; org.el ends here
