(add-to-list 'load-path user-emacs-directory) ;; ~/.emacs.d
(setq is-mac (equal system-type 'darwin))


(require 'setup-package)
(require 'setup-vendor)


;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'setup-misc)
(require 'setup-file-associations)

(require 'setup-org-mode)

(require 'setup-eldoc)

(when is-mac
  (require 'setup-mac-osx)) 

;; Setup vendor. This should remain disabled until I figure out how to auto install the required packages

(require 'setup-key-bindings)
;; End of init.el
