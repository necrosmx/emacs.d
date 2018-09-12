(package-initialize)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(defun load-file-if-exists (file-name)
  (let ((file-path (expand-file-name file-name user-emacs-directory)))
    (when (file-exists-p file-path)
      (load-file file-path))))
(load-file-if-exists "custom.el")

(add-to-list 'load-path "~/.emacs.d/self")
(require 'package-manager)
(require 'common)
(require 'programing)

(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t
  :config
  (evil-mode))

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "M-g") 'magit-status))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (recentf-mode 1))

(use-package helm-projectile
  :ensure t
  :config
  (global-set-key (kbd "M-p") 'helm-projectile-switch-project)
  (global-set-key (kbd "M-o") 'helm-projectile-find-file)
  (global-set-key (kbd "M-F") 'projectile-grep)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-f") 'helm-find-files)
  (global-set-key (kbd "C-<tab>") 'helm-buffers-list))

(use-package js2-refactor
  :ensure t)

(use-package xref-js2
  :ensure t)

(use-package prettier-js
  :ensure t)

(use-package rjsx-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
  (define-key js2-mode-map (kbd "M-.") nil)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (add-hook 'js2-mode-hook (lambda ()
                             (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)
                             (superword-mode 1)
                             (prettier-js-mode)
                             )))

(use-package indium
  :ensure t)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-j") 'ace-window)
  (global-set-key (kbd "M-k") 'ace-delete-window)
  (setq aw-keys '(?g ?c ?r ?h ?t ?n ?m ?w ?v))
  (advice-add 'ace-window :after #'golden-ratio))

(use-package git-gutter-fringe+
  :ensure t
  :config
  (global-git-gutter+-mode)
  (setq-default fringes-outside-margins t)
  (fringe-helper-define 'git-gutter-fr+-added nil
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr+-modified nil
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    "XXX....."
    )
  (fringe-helper-define 'git-gutter-fr+-deleted nil
    "........"
    "........"
    "........"
    "........"
    "........"
    "........"
    "........"
    "........"
    "........"
    "........"
    "........"
    "........"
    "........"
    "X......."
    "XX......"
    "XXX....."
    "XXXX...."))

(use-package company
  :ensure t
  :config
  (global-company-mode))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode))

(use-package flx
  :ensure t)

(use-package company-flx
  :ensure t)

(use-package helm
  :ensure t
  :config
  (require 'helm-config))

(use-package avy
  :ensure t
  :bind (("M-s" . avy-goto-word-1)))

(use-package dired-sidebar
  :ensure t
  :bind (("M-0" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode)))
            )
  :config
  (setq dired-sidebar-theme 'vscode))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "M-e") 'er/expand-region))

(use-package paradox
  :ensure t)

(use-package nlinum
  :ensure t
  :config
  (setq nlinum-highlight-current-line t)) ;; TODO: Not sure yet

;; Perspective mode is not working well with desktop-save-mode
;; (use-package perspective
;;   :ensure t
;;   :config
;;   (persp-mode)) ;; TODO came up with some better keybindings

(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 1))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package all-the-icons-dired
  :ensure t
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package restclient
  :ensure t)

(winner-mode 1)

;; TODO mu4e, undo-tree

;; TODO move this function into the self directory
(defun self/open-config-file ()
  "Opens my configuration file"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "M-,") 'self/open-config-file)

(global-set-key (kbd "C-x t") 'eshell)
(setq eshell-glob-case-insensitive t)
(setq eshell-cmpl-ignore-case t)

(global-subword-mode t)

(blink-cursor-mode 0)

;; Theme
(set-face-attribute 'default nil :height 130)
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one))
(set-default-font "Source Code Pro")

;; Save and restore the session
(desktop-save-mode 1)

;; (require 'astrologit-mode)
; TODO: make mode for jest
; TODO: make mode for sport scores
; TODO: make mode for displaying git annotations on current line a la gitlens
