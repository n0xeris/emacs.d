;;; writing.el --- Writing environment -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Writing Mode Configuration (Distraction-Free Environment)
;;------------------------------------------------------------------------------

(use-package olivetti
  :config
  ;; Set your preferred baseline layout width right when the package loads
  (setq olivetti-body-width 80))

(defun custom-toggle-writing-mode ()
  "Toggle a complete distraction-free environment for writing."
  (interactive)
  (cond ((bound-and-true-p olivetti-mode)
         ;; Turning writing mode OFF
         (setq olivetti-hide-mode-line nil)
         (olivetti-mode -1)
         (toggle-frame-fullscreen)
         ;; Upgraded from legacy linum-mode to native fast line numbering
         (when (fboundp 'display-line-numbers-mode)
           (display-line-numbers-mode 1)))
        (t
         ;; Turning writing mode ON
         ;; Correct modern implementation to hide the modeline safely
         (setq olivetti-hide-mode-line t)
         (olivetti-mode 1)
         (toggle-frame-fullscreen)
         (menu-bar-mode -1)
         ;; Turn off line numbers to maximize clean visual space
         (when (fboundp 'display-line-numbers-mode)
           (display-line-numbers-mode -1)))))

;; Toggle writing mode globally (Works seamlessly across all modes, including Org)
(global-set-key (kbd "C-c C-w") #'custom-toggle-writing-mode)


(provide 'writing)
;;; writing.el ends here
