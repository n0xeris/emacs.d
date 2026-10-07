;;; dev-keybinds.el --- Keybinds for development -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Keybinds for Development (Clean Syntax Version)
;;------------------------------------------------------------------------------

;; vterm pop-up integration
(global-set-key (kbd "C-'") #'vterm-toggle)

;; eldoc buffer query
(global-set-key (kbd "C-c C-m") #'eldoc-doc-buffer)

;; code navigation through imenu and lsp engines
(global-set-key (kbd "C-c i") #'imenu)
(global-set-key (kbd "C-c c d") #'lsp-find-definition)
(global-set-key (kbd "C-c c l") #'lsp-find-declaration)

;; regex find-and-replace variables
(global-set-key (kbd "C-c x") #'replace-regexp) ; In-buffer replacement

;; project shortcuts
(global-set-key (kbd "C-c p d") #'project-forget-project)
(global-set-key (kbd "C-c p x") #'project-query-replace-regexp) ; Cross-project regex replace


;;------------------------------------------------------------------------------
;; Advanced Line Duplication Utility Engine
;;------------------------------------------------------------------------------

(defun custom-duplicate-line (comment-first)
  "Duplicate the current line cleanly.

When COMMENT-FIRST is non-nil (e.g., when called with a universal
prefix argument `C-u`), the original line is commented out before
the duplicate is inserted below it.  Otherwise, the line is simply
copied as-is."
  (interactive "P")
  (let ((line-text (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))))
    (save-excursion
      (if comment-first
          (progn
            (comment-line 1)
            (move-beginning-of-line 1)
            (open-line 1))
        (move-end-of-line 1)
        (open-line 1)
        (forward-char 1))
      (insert line-text))
    ;; Safe programmatic layout shift across boundaries
    (forward-line 1)))

;; Map to a safe global shortcut binding
(global-set-key (kbd "C-c d") #'custom-duplicate-line)


(provide 'dev-keybinds)
;;; dev-keybinds.el ends here
