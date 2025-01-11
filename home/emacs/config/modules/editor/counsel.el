;;; counsel.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;; make search easier

;;; Code:

(require 'core/keybinds)
(require 'recentf)
(recentf-mode 1)


(use-package counsel
  :bind (("M-x" . counsel-M-x)
     :map minibuffer-local-map
     ("C-r" . 'counsel-minibuffer-history)))

(use-package swiper)

(use-package ivy
  :diminish
  :bind (("M-s" . swiper)
         :map ivy-minibuffer-map
         ("C-l" . ivy-alt-done)
         ("M-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         ("M-j" . ivy-next-line)
         ("M-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-l" . ivy-done)
         ("M-l" . ivy-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         ("M-j" . ivy-next-line)
         ("M-k" . ivy-previous-line)
         ("C-h" . ivy-switch-buffer-kill)
         ("M-h" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(general-create-definer file-menu-definer
  :wrapping global-definer
  :prefix "SPC f"
  "" '(:ignore t :wk "file"))


(file-menu-definer
  "f" '(counsel-find-file :wk "find file")
  "b" '(counsel-bookmark :wk "find file")
  "d" '(counsel-dired :wk "Counsel dired")
  "D" '(dired-jump :wk "Dired jump")
  "r" '(counsel-recentf :wk "recent file")
  "t" '(counsel-load-theme :wk "recent file")
  "s" '(write-file :wk "save file")
)




(use-package nerd-icons-dired
  :hook (dired-mode . (lambda () (nerd-icons-dired-mode t))))
(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))
(use-package ivy-rich ;; This gets us descriptions in M-x.
  :init (ivy-rich-mode 1))
(use-package nerd-icons-ivy-rich ;; Adds icons to M-x.
  :init (nerd-icons-ivy-rich-mode 1))

(provide 'editor/counsel)
;;; counsel.el ends here
