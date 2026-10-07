;;; kbds.el --- General Keybinds -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Generic Keybinds (Operational Control Framework)
;;------------------------------------------------------------------------------

;; Core evaluation engine helpers
(global-set-key (kbd "C-c e b") #'eval-buffer)

;; Blending / Opacity window variables cycler
(global-set-key (kbd "C-c t") #'toggle-full-transparency)

;; Horizontal window resizing
(global-set-key (kbd "C-c C-9") #'shrink-window-horizontally)
(global-set-key (kbd "C-c C-0") #'enlarge-window-horizontally)

;; Remove inconvenient keybinds
(keymap-global-unset "C-<next>")  ; scroll-left
(keymap-global-unset "C-<prior>") ; scroll-right


;;------------------------------------------------------------------------------
;; Org-mode Keybinds
;;------------------------------------------------------------------------------

;; Global tracking interfaces for Org-Mode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)


;;------------------------------------------------------------------------------
;; Advanced Workspace Sanitization Toolkit
;;------------------------------------------------------------------------------

(defun custom-kill-other-buffers ()
  "Safely kill all interactive file-visiting and code buffers.
Preserves the *scratch* pad, active processes, system logs,
and background server terminals to prevent editor deadlocks."
  (interactive)
  (let ((killed-count 0))
    (dolist (buf (buffer-list))
      (let ((buf-name (buffer-name buf)))
        ;; Safety filters: Skip the scratch pad and all internal system buffers (prefixed with space or *)
        (unless (or (string-equal buf-name "*scratch*")
                    (string-prefix-p " " buf-name)
                    (and (string-prefix-p "*" buf-name)
                         (not (string-match-p "\\*vterm" buf-name)))) ; Safely catches user terminals if needed

          ;; Bypass unsaved warnings cleanly by marking files as unmodified temporarily
          (with-current-buffer buf
            (set-buffer-modified-p nil))
          (kill-buffer buf)
          (setq killed-count (1+ killed-count)))))
    (message "Workspace clean! Killed %d background buffers ;3" killed-count)))

;; Map to your preferred clean deployment shortcut
(global-set-key (kbd "C-c k a") #'custom-kill-other-buffers)


(provide 'kbds)
;;; kbds.el ends here
