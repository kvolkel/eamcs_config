(require 'package)
(setq package-archives '(
		         ("org" . "https://orgmode.org/elpa/")
			 ("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar myPackages
  '(
    use-package
    elpy
    )
)
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)
(require 'use-package)

(use-package tramp
  :config
  ; tramp stuff
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path) ;;this makes sure that tramp does not step on PATH setup at time of remote shell creation
  (add-to-list 'tramp-connection-properties 
             (list "/sshx:kvolkel@login.hpc.ncsu.edu" "remote-shell" "/bin/bash")) ;;starts a remote bash shell instead of a bourne shell, lets you load from remote .bashrc
)
;;mode packages
(use-package org
  :config
  (setq org-log-done t)
  (add-hook 'org-mode-hook 'visual-line-mode)
)
(use-package org-bullets
  :hook (( org-mode ) . org-bullets-mode))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package python
  :ensure t
  )

(use-package cmake-mode
  :ensure t
  )

(use-package eglot ;;language server client
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd")) ;;using clangd language server for c++/c
  (add-to-list 'eglot-managed-mode-hook #'(lambda () (add-to-list 'completion-at-point-functions (cape-company-to-capf #'company-yasnippet)))) ;; allow snippet and server completions
  (setq eldoc-echo-area-use-multiline-p nil)
  )

(use-package corfu ;;autocompletion package
  :ensure t
  :config
  (global-corfu-mode)
  (add-to-list 'completion-at-point-functions (cape-company-to-capf #'company-yasnippet))
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)
  (corfu-min-width 80)
  (corfu-max-width corfu-min-width)     
  (corfu-count 14)
  (corfu-scroll-margin 4)
  (corfu-cycle nil)
  (corfu-info-documentation t) 
  )
(use-package yasnippet-snippets 
  :ensure t
  )
(use-package yasnippet                  ; Snippets
  :ensure t
  :config
   (yas-global-mode t)
   )

(use-package cape ;;company autocompletion converter package
  :ensure t
  )

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; make ctrl-z undo
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)
(global-set-key (kbd "C-x w") 'make-frame-command)


(setq inhibit-startup-message t) 
(global-linum-mode t)   

(use-package spacemacs-theme
  :ensure t
  :config
  (load-theme 'spacemacs-dark t)
)


(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
    (setq c-basic-offset 8))


(defun scalpel ()
  (interactive)
  (dired "/ssh:kvolkel@scalpel08.ece.ncsu.edu:/home/kvolkel")
  )

(defun hpc ()
  (interactive)
  (dired "/sshx:kvolkel@login.hpc.ncsu.edu:/gpfs_backup/tuck_data/kvolkel")
  )



(setq auto-mode-alist
      (append '(("\\.tpp" . c++-mode)) auto-mode-alist ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cmake-mode cape zenburn-theme yasnippet-snippets yahtzee use-package undo-tree pyenv-mode org-bullets material-theme lsp-pyright immaterial-theme go-mode elpy eglot corfu conda color-theme better-defaults auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
