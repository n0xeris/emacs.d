;;; ui.el --- UI Customizations -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; UI Configuration Framework (Straight.el Native)
;;------------------------------------------------------------------------------

;; Turn off cluttering visual graphical boundaries early
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(setq initial-scratch-message ";; Hello, Sailor ;3\n")


;;------------------------------------------------------------------------------
;; Basic Dependencies
;;------------------------------------------------------------------------------

(use-package powerline
  :config
  (powerline-default-theme))

(use-package all-the-icons
  :if (display-graphic-p))


;;------------------------------------------------------------------------------
;; Typography Layout Engine
;;------------------------------------------------------------------------------

;; Default Font Settings
(add-to-list 'default-frame-alist '(font . "MonaspaceKryptonVar 15"))
(set-frame-font "MonaspaceKryptonVar 15" nil t)

;; Enables current ling highlighting
(global-hl-line-mode 1)


;;------------------------------------------------------------------------------
;; Native Line Number Metrics
;;------------------------------------------------------------------------------

(setq display-line-numbers-type 'relative) ; Relative line numbers
(global-display-line-numbers-mode 1)       ; Apply globally across file scopes

;; Target mode hooks to safely hide column markers
(setq no-linenumber-modes '(org-mode-hook
                            olivetti-mode-hook
                            vterm-mode-hook
                            vterm-toggle-mode-hook))

(dolist (hook no-linenumber-modes)
  (add-hook hook (lambda () (display-line-numbers-mode -1))))

;; Display ruler at colunm 80
(setq-default fill-column 80)
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)


;;------------------------------------------------------------------------------
;; Visual Elements & Theme Installation Pipeline
;;------------------------------------------------------------------------------

(setq custom-safe-themes t)

(use-package all-the-icons
  :if (display-graphic-p))

;; Disable all active custom themes first to prevent color bleeding
(mapc #'disable-theme custom-enabled-themes)

;; Custom theme
(load-theme 'n0x-royal-purple t)


;;------------------------------------------------------------------------------
;; Editing Engine Configurations (Org Link Mapping)
;;------------------------------------------------------------------------------

(setq org-return-follows-link t)

;; Structural Selection Multi-Editing Toolkit
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . #'mc/edit-lines)
         ("C-S-l"       . #'mc/keyboard-quit)
         ("C->"         . #'mc/mark-next-like-this)
         ("C-<"         . #'mc/mark-previous-like-this)))


;;------------------------------------------------------------------------------
;; Graphical Opacity / Window Blending Controls
;;------------------------------------------------------------------------------

;; Client window transparency levels
(set-frame-parameter (selected-frame) 'alpha '(100 . 90))
(add-to-list 'default-frame-alist '(alpha . (100 . 90)))

(defun toggle-full-transparency ()
  "Cycle frame visibility variables seamlessly."
  (interactive)
  (let ((alpha-min '(90 . 90))
        (alpha-max '(100 . 90))
        (alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter nil 'alpha
                         (if (eql (cond ((numberp alpha) alpha)
                                        ((numberp (car alpha)) (car alpha))
                                        ((numberp (caar alpha)) (caar alpha)))
                                  (car alpha-max))
                             alpha-min alpha-max))))


;;------------------------------------------------------------------------------
;; Scratch Buffer Preservation Mechanics
;;------------------------------------------------------------------------------

(use-package persistent-scratch
  :ensure t
  :config
  (persistent-scratch-setup-default))

(defun unkill-scratch-buffer ()
  "Rebuild an operational interaction frame if *scratch* is closed."
  (remove-hook 'kill-buffer-query-functions #'unkill-scratch-buffer)
  (kill-buffer (current-buffer))
  (with-current-buffer (get-buffer-create "*scratch*")
    (lisp-interaction-mode)
    (make-local-variable 'kill-buffer-query-functions)
    (add-hook 'kill-buffer-query-functions #'unkill-scratch-buffer))
  nil)

(with-current-buffer (get-buffer-create "*scratch*")
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions #'unkill-scratch-buffer))


;;------------------------------------------------------------------------------
;; Text Slide & Line Movement Controls
;;------------------------------------------------------------------------------

(use-package move-text
  :bind (("<C-M-up>"   . #'move-text-up)
         ("<C-M-down>" . #'move-text-down)))


;;------------------------------------------------------------------------------
;; dired configurations
;;------------------------------------------------------------------------------

;; prevents dired from spawning multiple buffers when navigating
(setq dired-kill-when-opening-new-dired-buffer t)


(provide 'ui)
;;; ui.el ends here
