;;; lang-haskell.el --- Haskell Configs  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Haskell Configuration
;;------------------------------------------------------------------------------

;; Map file extensions safely to ensure they trigger the correct modes
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs\\'" . haskell-cabal-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

;; Defer keymap configuration until haskell-mode is fully loaded into memory
(with-eval-after-load 'haskell-mode
  (define-key haskell-mode-map (kbd "RET") #'newline-and-indent))


;;------------------------------------------------------------------------------
;; Integration Setup & Language Server Handshake
;;------------------------------------------------------------------------------

(use-package lsp-haskell
  :after (lsp-mode haskell-mode)
  :config
  ;; Use the HLS wrapper binary to detect GHC versions adaptively
  (setq lsp-haskell-server-path "haskell-language-server-wrapper")
  ;; Tie build tooling preference: default is 'cabal (change to 'stack if needed)
  (setq lsp-haskell-formatting-provider "ormolu")) ; Options: "ormolu", "floskell", "fourmolu", "none"

(defun custom-haskell-prevent-auto-formatting ()
  "Prevents active formatting while preserving user structural indentation configurations."
  ;; Disables lsp-mode native format-on-save targeting Haskell buffers explicitly
  (setq-local lsp-enable-on-type-formatting nil)
  (setq-local lsp-before-save-edits-fn nil))

(defun custom-haskell-mode-setup ()
  "Custom configurations to run when entering Haskell Mode."
  ;; Enable aesthetic depth highlighting matching your C++ configs
  (rainbow-delimiters-mode 1)

  ;; Configure native structural indentation (Haskell is indentation-sensitive)
  (haskell-indentation-mode 1)

  ;; Ensure local formatting guidelines match your strict typing workflows
  (custom-haskell-prevent-auto-formatting)

  ;; Defer LSP to the end so it doesn't crash font-lock initialization
  (lsp-deferred))

;; Evaluate cleanly via a single hook function call
(add-hook 'haskell-mode-hook #'custom-haskell-mode-setup)


;;------------------------------------------------------------------------------
;; Interactive Repl Deployment Configuration (Optional)
;;------------------------------------------------------------------------------

(use-package haskell-mode
  :defer t
  :config
  ;; Ties C-c C-l directly to a cabal-driven REPL process buffer inside Emacs
  (setq haskell-process-type 'cabal)) ; Change to 'stack-ghci if using Stack


(provide 'lang-haskell)
;;; lang-haskell.el ends here
