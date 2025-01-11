;;; ui/theme ---  -*- lexical-binding: t; -*-

;;; Commentary:
;; Load up my current theme, whatever that may be.

;;; Code:
(require 'use-package)

(use-package remember-last-theme
  :config (remember-last-theme-enable))

(use-package ef-themes)

(provide 'ui/theme)
;;; theme.el ends here
