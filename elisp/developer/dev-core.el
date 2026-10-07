;;; dev-core.el --- Core configs for development -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Global Performance & Packages Configuration (Straight.el Native)
;;------------------------------------------------------------------------------

(setq gc-cons-threshold (* 100 1024 1024)    ; Garbage collection caps at 100MB
      read-process-output-max (* 1024 1024)  ; Read max of 1MB from processes
      treemacs-space-between-root-nodes nil  ; Disable extra vertical spaces
      company-idle-delay 0.1                 ; Company popup shows within 0.1s
      company-minimum-prefix-length 1        ; Company needs 1 character to pop
      lsp-idle-delay 0.1)                    ; Global LSP server delay window


;;------------------------------------------------------------------------------
;; Base LSP Config
;;------------------------------------------------------------------------------

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom
  (lsp-eldoc-render-all t)
  :config
  (add-hook 'lsp-mode-hook #'lsp-ui-mode))


;;------------------------------------------------------------------------------
;; Essential Development Packages
;;------------------------------------------------------------------------------

(use-package lsp-ui)             ; Display contextual LSP info in Emacs UI
(use-package lsp-treemacs)       ; Sidebar / file explorer
(use-package helm-lsp)           ; Incremental completion and narrowing selection
(use-package helm-xref)          ; Helm completion interface for Xref results
(use-package company)            ; Text completion framework (Complete Anything)
(use-package dap-mode)           ; Interface to debug code inside Emacs
(use-package rainbow-delimiters) ; Highlights parentheses, brackets, and braces by depth
(use-package glsl-mode)          ; GLSL Shading Language syntax support

(use-package magit)              ; git user interface
(use-package vterm)              ; system terminal inside emacs
(use-package vterm-toggle)       ; allows to toggle visibility of the terminal buffer


;;------------------------------------------------------------------------------
;; General Utility & Integration Hook Map
;;------------------------------------------------------------------------------

(which-key-mode)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools))


;;------------------------------------------------------------------------------
;; Helm Navigation Engine Interface
;;------------------------------------------------------------------------------

(helm-mode 1)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

;; Allowing <tab> completion by swapping the default <tab> and C-z commands.
(with-eval-after-load 'helm-files
    ;; For GUI.
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-find-files-map (kbd "S-<tab>") 'helm-find-files-up-one-level)
    (define-key helm-find-files-map (kbd "<backtab>") 'helm-find-files-up-one-level)

    ;; For terminal.
    (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
    (define-key helm-find-files-map (kbd "S-TAB") 'helm-find-files-up-one-level)
    (define-key helm-map (kbd "C-z") 'helm-select-action))


;;------------------------------------------------------------------------------
;; Flycheck - Syntax Checking and Linting Engine
;;------------------------------------------------------------------------------

(use-package flycheck
  :init
  ;; Globally activate syntax checking for all programming languages
  (global-flycheck-mode 1)
  :custom
  ;; Only check files when saving or opening, not on every keystroke.
  (flycheck-check-syntax-automatically '(save mode-enabled)))


;;------------------------------------------------------------------------------
;; Yasnippet - Global Structural Template Framework
;;------------------------------------------------------------------------------

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets)


(provide 'dev-core)
;;; dev-core.el ends here
