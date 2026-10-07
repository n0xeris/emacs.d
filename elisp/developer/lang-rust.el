;;; lang-rust.el --- Rust Configs -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Rust Configuration (Straight.el Compatible Layout)
;;------------------------------------------------------------------------------

(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; Native rustic formatting handles everything on save cleanly.
  (setq rustic-format-on-save t)

  ;; Rust-analyzer does structural fontification out-of-the-box.
  ;; We can disable downstream LSP clutter to increase rendering speed.
  (setq lsp-eldoc-hook nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-signature-auto-activate nil))


;; Optimized Hook Setup
(defun custom/rustic-mode-hook ()
  "Cleaned setup hook for rustic-mode."
  ;; The help buffers do NOT have a buffer-file-name.
  ;; To prevent them from asking to save, we mark them as modified-yet-safe if they are anonymous.
  (unless buffer-file-name
    (setq-local buffer-save-without-query t))

  ;; Ensure lsp loads lazily to keep Emacs responsive
  (lsp-deferred))

(add-hook 'rustic-mode-hook #'custom/rustic-mode-hook)

;; Code Annotations (LSP-Mode Language Specific Customizations)
(use-package lsp-mode
  :custom
  ;; Specific to Rust's cargo watch tool
  (lsp-rust-analyzer-cargo-watch-command "clippy")

  ;; Specific to Rust's inlay type hints engine
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil))


(defun check-expansion ()
  "Helper Indentation Logic (Preserved for Company Context Mapping)."
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  "Try to expand a snippet at point using Yasnippet.
Return nil instead of executing a fallback command if no snippet
matches the trigger key at point."
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  "Smart TAB handler for indentation, snippet expansion, and completion.
If in the minibuffer, perform `minibuffer-complete`.
Otherwise, attempt actions in the following order of priority:
1. Expand a Yasnippet trigger at point.
2. Complete using Company mode if a completion is available (`check-expansion`).
3. Fall back to standard indentation using `indent-for-tab-command`."
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))


;; Playground to quickly test Rust code snippet crates
(use-package rust-playground
  :bind (:map rust-playground-mode-map
              ("C-<return>" . rust-playground-exec)))

(global-set-key (kbd "C-c r p") #'rust-playground)
(global-set-key (kbd "C-c r m") #'rust-playground-rm)


(provide 'lang-rust)
;;; lang-rust.el ends here
