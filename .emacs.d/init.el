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
(set-face-attribute 'default nil :font "SauceCodePro Nerd Font")
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(doom-modeline use-package gruvbox-theme counsel command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

