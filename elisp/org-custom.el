;;; org-custom.el --- Org-Mode Configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Org Mode Tweaks & Customizations (Straight.el Native)
;;------------------------------------------------------------------------------

;; Load shared external utility extensions natively via Straight
(use-package find-lisp)
(use-package htmlize)

(with-eval-after-load 'htmlize
  (setq org-html-htmlize-output-type 'css))


;;------------------------------------------------------------------------------
;; Primary Org Core Engine Variables Configuration
;;------------------------------------------------------------------------------

(with-eval-after-load 'org
  (setq org-src-fontify-natively t)
  (setq org-support-shift-select t)
  (setq org-log-done t)
  (setq org-agenda-files (find-lisp-find-files "~/.org/docs" "\\.org$"))
  (setq org-directory "~/.org/docs")

  ;; Priority parameters for TODO outline listings
  (setq org-lowest-priority ?F)   ; Gives priorities A through F
  (setq org-default-priority ?E)  ; Unprioritized items fallback default is [#E]

  (setq org-priority-faces
        '((65 . "#BF616A")
          (66 . "#EBCB8B")
          (67 . "#B48EAD")
          (68 . "#81A1C1")
          (69 . "#5E81AC")
          (70 . "#4C566A")))

  ;; Stages workflow cycle tracking keywords for TODO nodes
  (setq org-todo-keywords
        '((sequence "TODO" "DOING" "WAIT" "REVIEW" "|" "DONE"))))


;;------------------------------------------------------------------------------
;; Structural Emphasis Expansion Controls
;;------------------------------------------------------------------------------

(use-package org-appear
  :commands (org-appear-mode)
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-hide-emphasis-markers t ; Required global flag for org-appear engine
        org-appear-autoemphasis   t ; Expand bold, italics, code, and verbatim
        org-appear-autolinks      t ; Unhide underlying destination target links
        org-appear-autosubmarkers t))


;;------------------------------------------------------------------------------
;; Typography, Icons, and Heading Customizations
;;------------------------------------------------------------------------------

(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-leading-bullet " ") ; Keeps indent clear to minimize left-side margins
  (setq org-superstar-headline-bullets-list '("◉" "○" "⚬" "◈" "◇"))
  (setq org-superstar-special-todo-items t) ; Renders states using neat geometric boxes
  (setq org-superstar-todo-bullet-alist '(("TODO"   . 9744)
                                          ("DOING"  . 9744)
                                          ("WAIT"   . 9744)
                                          ("REVIEW" . 9744)
                                          ("DONE"   . 9745))))

;; Modern Layout Heading Scaling Engine
(with-eval-after-load 'org-faces
  (dolist (face '(org-level-1 org-level-2 org-level-3 org-level-4
                  org-level-5 org-level-6 org-level-7 org-level-8))
    (set-face-attribute face nil :weight 'bold :height 1.1))

  ;; Document dashboard title configuration
  (set-face-attribute 'org-document-title nil :weight 'bold :height 1.1))


;;------------------------------------------------------------------------------
;; Visual Symbol Substitution Layout Engine
;;------------------------------------------------------------------------------

(defun custom-prettify-symbols-setup ()
  "Apply clean graphical symbols to checkboxes and structural code blocks."
  (setq prettify-symbols-alist
        '(;; Checkbox States
          ("[ ]" . "")
          ("[X]" . "")
          ("[-]" . "")

          ;; Org Babel Source Code Blocks Markup markers
          ("#+BEGIN_SRC" . ?≫)
          ("#+END_SRC"   . ?≫)
          ("#+begin_src" . ?≫)
          ("#+end_src"   . ?≫)

          ;; Quotation environments layout containers
          ("#+BEGIN_QUOTE" . ?❝)
          ("#+END_QUOTE"   . ?❞)
          ("#+begin_quote" . ?❝)
          ("#+end_quote"   . ?❞)

          ;; File Database Metadata Properties Drawers
          (":PROPERTIES:" . "")

          ;; Contextual Tag Identifiers
          (":projects:" . "")
          (":work:"     . "")
          (":inbox:"    . "")
          (":task:"     . "")
          (":thesis:"   . "")
          (":uio:"      . "")
          (":emacs:"    . "")
          (":learn:"    . "")
          (":code:"     . "")))

  (prettify-symbols-mode 1))

;; Mount the prettify engine hooks onto your operational workspace environments
(add-hook 'org-mode-hook        #'custom-prettify-symbols-setup)
(add-hook 'org-agenda-mode-hook #'custom-prettify-symbols-setup)


(provide 'org-custom)
;;; org-custom.el ends here
