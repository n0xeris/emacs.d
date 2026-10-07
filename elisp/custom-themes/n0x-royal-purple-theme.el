;;; n0x-royal-purple-theme.el --- n0x-royal-purple -*- lexical-binding: t; -*-
;;; Commentary:
;;; Version: 1.0
;;; Author: n0xeris
;;; Code:


(deftheme n0x-royal-purple "Purple, thats it.")

(let ((bg-main          "#171130")  ; Main editor background
      (bg-alt           "#140b29")  ; Status bar / secondary background
      (fg-main          "#ffffff")  ; General text foreground
      (fg-muted         "#696969")  ; Comments and delimiters

      (highlight-accent "#fd61b8")  ; Prompts, selections, active items
      (highlight-match  "#ffaa00")  ; Matching search queries
      (highlight-region "#583f31")  ; Selected block background
      (highlight-block  "#3e3834")  ; Secondary text block selections
      (highlight-line   "#211844")  ; Current line
      (ui-border        "#261c4e")  ; UI layout dividers / indicators
      (ui-border-alt    "#392e66")  ; UI layout dividers / indicators

      (syntax-keyword   "#ff68bc")  ; Language control statements
      (syntax-builtin   "#fe8019")  ; Integrated language primitives
      (syntax-string    "#ffb73b")  ; Text strings and documentation
      (syntax-type      "#45df79")  ; Declared data structures / classes
      (syntax-entity    "#00adff")) ; Functions, constants, numbers

     (custom-theme-set-faces 'n0x-royal-purple
          `(default ((t (:foreground ,fg-main :background ,bg-main ))))
          `(cursor ((t (:background ,fg-main ))))
          `(fringe ((t (:background ,bg-main ))))
          `(region ((t (:background ,highlight-region ))))
          `(secondary-selection ((t (:background ,highlight-block ))))

          `(font-lock-builtin-face ((t (:foreground ,syntax-builtin ))))
          `(font-lock-comment-face ((t (:foreground ,fg-muted ))))
          `(font-lock-comment-delimiter-face ((t (:foreground ,fg-muted ))))
          `(font-lock-keyword-face ((t (:foreground ,syntax-keyword ))))
          `(font-lock-string-face ((t (:foreground ,syntax-string ))))
          `(font-lock-type-face ((t (:foreground ,syntax-type ))))
          `(font-lock-constant-face ((t (:foreground ,syntax-entity ))))
          `(font-lock-variable-name-face ((t (:foreground ,fg-main ))))
          `(font-lock-variable-use-face ((t (:foreground ,fg-main ))))
          `(font-lock-function-name-face ((t (:foreground ,syntax-entity ))))
          `(font-lock-function-call-face ((t (:foreground ,syntax-entity ))))
          `(font-lock-doc-face ((t (:foreground ,syntax-string ))))
          `(font-lock-doc-markup-face ((t (:foreground ,syntax-entity ))))

          `(font-lock-escape-face ((t (:foreground ,syntax-string ))))
          `(font-lock-number-face ((t (:foreground ,syntax-entity ))))
          `(font-lock-operator-face ((t (:foreground ,syntax-entity ))))
          `(font-lock-property-name-use-face ((t (:foreground ,fg-main ))))
          `(font-lock-property-use-use-face ((t (:foreground ,fg-main ))))
          `(font-lock-punctuation-use-face ((t (:foreground ,fg-main ))))
          `(font-lock-bracket-use-face ((t (:foreground ,fg-main ))))
          `(font-lock-delimiter-use-face ((t (:foreground ,fg-main ))))

          `(minibuffer-prompt ((t (:foreground ,highlight-accent :bold t ))))
          `(font-lock-warning-face ((t (:foreground "red" :bold t ))))
          `(fill-column-indicator ((t (:foreground ,ui-border))))

          `(line-number ((t (:foreground ,fg-muted :background ,bg-main :underline nil :strike-through nil))))
          `(line-number-current-line ((t (:foreground ,highlight-accent :background ,bg-main :bold t))))
          `(hl-line ((t (:background ,highlight-line :extend t))))

          ;;; Top Window Breadcrumbs & Header Line Colors
          `(header-line ((t (:background ,bg-alt :foreground ,fg-main :box nil))))

          `(lsp-headerline-breadcrumb-path-face ((t (:foreground ,fg-main :weight normal :underline nil))))
          `(lsp-headerline-breadcrumb-symbols-face ((t (:foreground ,syntax-type :weight bold))))
          `(lsp-headerline-breadcrumb-separator-face ((t (:foreground ,fg-muted))))

          `(breadcrumb-project-crumbs-face ((t (:foreground ,fg-main))))
          `(breadcrumb-imenu-crumbs-face ((t (:foreground ,syntax-type :weight bold))))

          ;;; Tab-Bar Mode
          `(tab-bar ((t (:background ,bg-alt :foreground ,fg-main))))
          `(tab-bar-tab ((t (:background ,bg-main :foreground ,syntax-entity :weight bold))))
          `(tab-bar-tab-inactive ((t (:background ,bg-alt :foreground ,fg-muted))))

          ;;; Tab-Line Mode
          `(tab-line ((t (:background ,bg-alt :foreground ,fg-main))))
          `(tab-line-tab ((t (:background ,bg-main :foreground ,syntax-entity :weight bold))))
          `(tab-line-tab-current ((t (:background ,bg-main :foreground ,syntax-entity :weight bold))))
          `(tab-line-tab-inactive ((t (:background ,bg-alt :foreground ,fg-muted))))

          ;;; Helm
          `(helm-selection ((t (:background ,syntax-keyword :foreground ,fg-main :extend t))))
          `(helm-source-header ((t (:background ,bg-alt :foreground ,syntax-keyword :weight bold))))
          `(helm-match ((t (:foreground ,highlight-match :weight bold))))

          `(helm-ff-directory ((t (:foreground ,syntax-entity :background nil :weight normal))))
          `(helm-ff-file ((t (:foreground ,fg-main :background nil))))
          `(helm-buffer-directory ((t (:foreground ,syntax-entity :weight normal))))

          ;;; Powerline Colors
          `(mode-line ((t (:foreground ,fg-main :background ,bg-alt ))))
          `(powerline-active1 ((t (:background ,ui-border :foreground ,syntax-entity :inherit mode-line))))
          `(powerline-active2 ((t (:background ,ui-border-alt :foreground ,fg-main :inherit mode-line))))

          `(mode-line-inactive ((t (:foreground ,fg-main :background ,bg-alt ))))
          `(powerline-inactive1 ((t (:background ,ui-border :foreground ,syntax-entity :inherit mode-line))))
          `(powerline-inactive2 ((t (:background ,ui-border-alt :foreground ,fg-main :inherit mode-line))))
          ))


;;; Autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))


(provide-theme 'n0x-royal-purple)
;;; n0x-royal-purple-theme.el ends here
