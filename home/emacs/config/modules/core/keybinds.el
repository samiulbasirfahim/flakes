;;; keybinds.el --- -*- lexical-binding: t; -*-

;;; Commentary:
;; keybinds

;;; Code:
(require 'use-package)

(use-package general
  :straight t
  :functions
  global-definer
  global-motion-definer
  model-leader-definer
  :config
  (general-evil-setup)
  (general-auto-unbind-keys))

(general-create-definer global-definer
  :keymaps 'override
  :states '(insert emacs normal hybrid motion visual operator)
  :prefix "SPC"
  :non-normal-prefix "C-SPC")


(general-create-definer global-surround-definer
  :keymaps 'override
  :states '(motion visual)
  :prefix "s")

(general-create-definer global-motion-definer
  :keymaps 'override
  :states '(normal motion visual operator)
  :prefix "g")

(general-create-definer mode-leader-definer
  :states '(normal motion)
  :wrapping global-definer
  :prefix "SPC m"
  "" '(:ignore t :which-key "mode"))


(use-package evil
  :straight t
  :init
  (setq evil-esc-delay 0
        evil-want-keybinding nil
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-respect-visual-line-mode t
        evil-undo-system 'undo-redo) ; Only Emacs 28+!
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  :config
  (evil-mode 1))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :straight t
  :after evil
  :general
  (global-surround-definer
    "a" 'evil-surround-region
    "c" 'evil-surround-change
    "d" 'evil-surround-delete)
  :config
  (global-evil-surround-mode 1))

(use-package evil-nerd-commenter
  :straight t
  :config
  :general
  (global-motion-definer
    "c" 'evilnc-comment-operator))

(use-package which-key
  :straight t
  :diminish which-key-mode
  :config (which-key-mode))

(global-set-key [escape] 'keyboard-escape-quit)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "M-=") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)


(provide 'core/keybinds)
;;; keybinds.el ends here
