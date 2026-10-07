;;; lang-cc.el --- C/C++ Configs -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; C / C++ Configuration
;;------------------------------------------------------------------------------

;; Map file extensions safely to ensure they trigger the correct modes
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

;; Set standard coding style fallback variables globally
(setq-default
  c-basic-offset 4
  tab-width 4
  indent-tabs-mode nil)

;; Defer keymap configuration until cc-mode is fully loaded into memory
(with-eval-after-load 'cc-mode
  ;; Force C/C++ mode to use simple relative indentation instead of its complex parser
  (setq-default indent-line-function 'indent-relative-first-indent-point)

  (define-key c-mode-base-map (kbd "RET") #'newline-and-indent)
  (define-key c-mode-base-map (kbd "TAB") #'tab-to-tab-stop))

(defun custom-prevent-auto-formatting ()
  "Prevent auto-formatting while preserves auto-indentation."
  (c-toggle-electric-state -1)
  (c-toggle-auto-newline -1)
  (setq indent-line-function 'tab-to-tab-stop)
  (c-set-style "user")
  ;; kill formatting hooks globally and locally
  (remove-hook 'before-save-hook #'lsp-format-buffer)   ; Global kill
  (remove-hook 'before-save-hook #'lsp-format-buffer t) ; Local kill
  ;; absolute safety fallback triggers
  (setq-local lsp-format-on-save nil)
  (setq-local lsp-format-buffer-on-save nil)
  (setq-local lsp-enable-on-type-formatting nil)
  (setq-local lsp-before-save-edits nil)
  (setq-local indent-line-function #'indent-relative-first-indent-point))

(defun custom-c-mode-setup ()
  "Custom configurations to run when entering C Mode."
  (rainbow-delimiters-mode 1)
  (setq flycheck-gcc-language-standard "c23")
  (setq flycheck-clang-language-standard "c23")
  (custom-prevent-auto-formatting)
  (lsp-deferred))

(defun custom-cpp-mode-setup ()
  "Custom configurations to run when entering C++ Mode."
  (rainbow-delimiters-mode 1)
  (setq flycheck-gcc-language-standard "c++23")
  (setq flycheck-clang-language-standard "c++23")
  (custom-prevent-auto-formatting)
  (lsp-deferred))

;; Evaluate cleanly via a single hook function call
(add-hook 'c-mode-hook #'custom-c-mode-setup)
(add-hook 'c++-mode-hook #'custom-cpp-mode-setup)


(provide 'lang-cc)
;;; lang-cc.el ends here
