;;; journal.el --- Configures Org-Roam (PKM) -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;------------------------------------------------------------------------------
;; Org-Roam Knowledge Base Configuration (Straight.el Native)
;;------------------------------------------------------------------------------

(use-package org-roam
  :init
  ;; Global keymaps using standard sharp-quoting mechanics
  (setq org-roam-v2-ack t) ; Suppress migration warnings if using older databases
  :bind (("C-c n l" . #'org-roam-buffer-toggle) ; Displays backlinks window
         ("C-c n f" . #'org-roam-node-find)     ; Find or create a knowledge node
         ("C-c n s" . #'org-id-get-create)      ; Safe heading node identifier generation
         ("C-c n i" . #'org-roam-node-insert)   ; Interactively insert links at point
         ("C-c n a" . #'org-roam-alias-add)     ; Append a fast structural lookup alias
         ("C-c n t" . #'org-roam-tag-add)       ; Tag management interface tool
         :map org-mode-map
         ("C-M-i"   . #'completion-at-point))   ; In-buffer link autocompletion lookup

  :bind-keymap ("C-c n d" . org-roam-dailies-map) ; Mount internal daily logging map
  :config
  ;; Moved variable assignments here so Org-Roam applies them to the database engine
  (setq org-roam-directory (file-truename "~/.org/journal/")
        org-roam-completion-everywhere t)

  ;; Capture Templates System
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
           :unnarrowed t)))

  ;; Explicitly require org-id so the 'C-c n s' binding functions perfectly
  (require 'org-id)
  (require 'org-roam-dailies)

  ;; Initialize database background tracking synchronization automatically
  (org-roam-db-autosync-enable))


(provide 'journal)
;;; journal.el ends here
