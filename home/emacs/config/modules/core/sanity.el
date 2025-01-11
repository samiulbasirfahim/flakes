;;; sanity.el --- -*- lexical-binding: t; -*-

;;; Commentary:
;; Make stuff not misbehave outright.

;;; Code:
(require 'use-package)


(delete-selection-mode 1)
(electric-pair-mode 1)
(global-visual-line-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq use-dialog-box nil)
(setq use-file-dialog nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")

;; Don't generate the godawful autosave files.
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Scroll line-by-line.
(setq scroll-conservatively 101)
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)
(setq redisplay-skip-fontification-on-input t)

;; Make yes/no prompts use y/n instead.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Go fast.
(setq native-comp-speed 2)

;; Stop yelling about warnings.
(setq warning-minimum-level :error)

(defun rxen/generate-tab-stops (&optional max)
  "Return a sequence suitable for `tab-stop-list'."
  (let* ((max-column (or max 200))
         (count (/ max-column tab-width)))
    (number-sequence tab-width (* tab-width count) tab-width)))

(setq tab-width 4)
(setq tab-stop-list (rxen/generate-tab-stops 4))
(setq-default indent-tabs-mode nil)


(provide 'core/sanity)
;;; sanity.el ends here
