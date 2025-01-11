(add-to-list 'load-path "~/.emacs.d/modules")

(defun reload-emacs() (interactive)
  (load-file "~/.emacs.d/init.el"))

(setq user-full-name "Samiul Basir Fahim"
      user-mail-address "samiulbasirfahim.rxen@gmail.com")

(require 'core/straight)
(require 'core/sanity)
(require 'core/keybinds)

(require 'ui/theme)
(require 'ui/modeline)
(require 'ui/misc)
(require 'ui/dashboard)
(require 'editor/counsel)
(require 'editor/keybinds)
(require 'lang/org)



(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

