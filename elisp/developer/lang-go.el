;;; lang-go.el --- Golang Configs -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Golang support
;;------------------------------------------------------------------------------

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :hook ((go-mode . lsp-deferred)                ; Connects to your existing lsp-mode setup
         (go-mode . subword-mode)                ; Better camelCase navigation
         (before-save . lsp-format-buffer)       ; LSP-driven formatting on save
         (before-save . lsp-organize-imports))   ; Automatically cleans up imports on save
  :config
  ;; Customizing LSP-mode settings specifically for Go
  (setq lsp-go-gopls-server-path "gopls"
        lsp-go-analyses '((unusedparams . t)     ; Warn about unused parameters
                          (shadow . t)           ; Warn about shadowed variables
                          (nilness . t))         ; Check for unexpected nil pointers
        lsp-go-codelenses '((gc_details . t)     ; Toggle showing optimization/escape details
                            (generate . t)       ; Run go generate from lens
                            (test . t))))        ; Run tests directly via code lenses


;;------------------------------------------------------------------------------
;; Debugging Integration (Delve + DAP-mode)
;;------------------------------------------------------------------------------

(with-eval-after-load 'dap-mode
  (require 'dap-go)
  ;; Automatically sets up debugging templates for Go applications and tests
  (dap-go-setup))


(provide 'dev-go)
;;; dev-go.el ends here
