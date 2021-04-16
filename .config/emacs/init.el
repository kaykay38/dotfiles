;-----------------------------------------------------------------------
; PACKAGE SETTINGS
;-----------------------------------------------------------------------
;; Package repository sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
;; Initialize use-package on linux platforms
(unless (package-installed-p 'use-package))
(package-install 'use-package)
(require 'use-package)
(setq use-package-always-ensure t)
;-----------------------------------------------------------------------
; APPEARANCE SETTINGS 
;-----------------------------------------------------------------------
;; Disable startup welcome page
(setq inhibit-startup-message t) 
;; Enable scrollbar
(scroll-bar-mode 1)
;; Scroll bar style
(set-face-background 'scroll-bar "#3c3836")
;; Scroll bar width
;; Disable toolbar
(tool-bar-mode -1) 
;; Enable menubar
(menu-bar-mode 1) 
;; Side border padding
(set-fringe-mode 10)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; Number lines
(global-display-line-numbers-mode)
;; Font
(set-face-attribute 'default nil :font "FiraMono Nerd Font 11")
;; Theme
(load-theme 'gruvbox-dark-medium t)
;; Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode)
  :custom (doom-modeline-height 15))
;; Cursor Shape
(setq-default cursor-type 'bar)
;; Cursorline
(global-hl-line-mode +1)
;; Disable breakline/continuation symbol
(setf (cdr (assq 'continuation fringe-indicator-alist))
      '(nil nil) ;; no continuation indicators
      ;; '(nil right-curly-arrow) ;; right indicator only
      ;; '(left-curly-arrow nil) ;; left indicator only
      ;; '(left-curly-arrow right-curly-arrow) ;; default
      )
;-----------------------------------------------------------------------
; Dired
;-----------------------------------------------------------------------
(require 'dired)
(setq dired-recursive-copies (quote always)) ; “always” means no asking
(setq dired-recursive-deletes (quote top)) ; “top” means ask once
(setq dired-listing-switches "-lXGh --group-directories-first")
(defun xah-dired-mode-setup ()
  "to be run as hook for `dired-mode'."
  (dired-hide-details-mode 1))
(add-hook 'dired-mode-hook 'xah-dired-mode-setup)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "l") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "DEL") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(define-key dired-mode-map (kbd "j") 'dired-next-line)
(define-key dired-mode-map (kbd "k") 'dired-previous-line)
(define-key dired-mode-map (kbd "/") 'find-name-dired)
(define-key dired-mode-map (kbd "C-x c") 'dired-ranger-copy)
(define-key dired-mode-map (kbd "C-x x") 'dired-ranger-move)
(define-key dired-mode-map (kbd "C-x v") 'dired-ranger-paste)
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))
;-----------------------------------------------------------------------
; SETTINGS
;-----------------------------------------------------------------------
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
;-----------------------------------------------------------------------
; KEY MAPPINGS
;-----------------------------------------------------------------------
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(cua-mode t)
;-----------------------------------------------------------------------
; PACKAGES USED
;-----------------------------------------------------------------------
;; Show command history
(use-package command-log-mode)
(use-package ivy :diminish
             :bind (("C-s" . swiper)
                    :map ivy-minibuffer-map
                    ("TAB" . ivy-alt-done)
                    ("C-l" . ivy-alt-done)
                    ("C-j" . ivy-next-line)
                    ("C-k" . ivy-previous-line)
                    :map ivy-switch-buffer-map
                    ("C-k" . ivy-previous-line)
                    ("C-l" . ivy-done)
                    ("C-d" . ivy-switch-buffer-kill)
                    :map ivy-reverse-i-search-map
                    ("C-k" . ivy-previous-line)
                    ("C-d" . ivy-reverse-i-search-kill))
                    :config
                    (ivy-mode 1))
(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs :ensure t)
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :commands (lsp lsp-deferred)
  :hook (
	 (csharp-mode . lsp-deferred))
  :config
  (lsp-enable-which-key-integration t))
;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))
(use-package csharp-mode
  :ensure t
  :hook (csharp-mode . lsp-deferred)
  :config
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-tree-sitter-mode)))

(defun my-csharp-mode-hook ()
  ;; enable the stuff you want for C# here
  (electric-pair-mode 1)       ;; Emacs 24
  (electric-pair-local-mode 1) ;; Emacs 25
  )
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)
(defun lsp-csharp--language-server-command ()
  "Resolves path and arguments to use to start the server."
  (list (lsp-csharp--language-server-path) "-lsp" "-l" "0"
"msbuild:MSBuildExtensionsPath=/usr/lib/mono/xbuild"
"msbuild:TargetFrameworkRootPath=/usr/lib/mono/xbuild-frameworks"
"msbuild:MSBuildSDKsPath=/lib/mono/msbuild/Current"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(projectile which-key lsp-mode csharp-mode doom-modeline use-package gruvbox-theme counsel command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
