;;; dashboard.el --- -*- lexical-binding: t; -*-

;;; Commentary:
;; dashboard

;;; Code:

(require 'core/keybinds)

(use-package dashboard
  :straight t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-items '((recents   . 5)
                        (bookmarks . 3)
                        ;; (agenda    . 3)
                        ))
(setq dashboard-startup-banner "~/.emacs.d/avatar.png")
(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

;; (add-hook 'dashboard-mode-hook #'dashboard-refresh-buffer)
  ;; Refresh dashboard when creating a new frame
(defun my-refresh-dashboard-on-new-frame (frame)
    "Refresh dashboard buffer when a new frame is created."
    (with-selected-frame frame
      (when (get-buffer "*dashboard*")
        (with-current-buffer "*dashboard*"
          (dashboard-refresh-buffer)))))


(global-definer
  "o d" '(dashboard-refresh-buffer :wk "Open dashboard"))

(add-hook 'after-make-frame-functions #'my-refresh-dashboard-on-new-frame)


(provide 'ui/dashboard)
;;; dashboard.el ends here
