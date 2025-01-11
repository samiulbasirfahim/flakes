;;; ui/misc ---  -*- lexical-binding: t; -*-

;;; Commentary:
;; disable and enable basic funtionality
;;; Code:
 
;; (use-package elcord)
;; (elcord-mode)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode 0)
(fringe-mode -1)

(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))


(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(add-to-list 'default-frame-alist
             '(font . "Rxen Sans-18"))

;; Optional: Improve performance by limiting fontset fallback
;; (setq inhibit-compacting-font-caches t)

(provide 'ui/misc)
;;; misc.el ends here
