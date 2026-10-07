;;; lang-lua.el --- Lua Configs -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Lua / Love2D Configuration
;;------------------------------------------------------------------------------

;; Map file extensions safely to ensure they trigger the correct modes
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))

;; Set standard coding style fallback variables globally
(setq-default
 lua-indent-level 4
 tab-width 4
 indent-tabs-mode nil)

;; Explicitly install and configure lua-mode via Straight.el
(use-package lua-mode
  :straight t
  :defer t
  :config
  ;; Defer keymap configuration until lua-mode is fully loaded into memory
  (define-key lua-mode-map (kbd "RET") #'newline-and-indent)
  ;; Map M-p to run or restart the Love2D project instantly
  (define-key lua-mode-map (kbd "M-p") #'custom-love2d-run))

;; Group hook modifications cleanly into isolated setups
(defun custom-lua-mode-setup ()
  "Custom configurations to run when entering Lua Mode."
  (rainbow-delimiters-mode 1)

  ;; Prevent documentation lookups from locking up the buffer
  (setq lua-documentation-url "https://lua.org")

  ;; Defer LSP to the end so it doesn't crash font-lock initialization
  (lsp-deferred))

;; Evaluate cleanly via a single hook function call
(add-hook 'lua-mode-hook #'custom-lua-mode-setup)


(provide 'lang-lua)
;;; lang-lua.el ends here
