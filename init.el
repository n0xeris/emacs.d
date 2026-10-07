;;; init.el --- Configuration entry point -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Basic Settings
;;------------------------------------------------------------------------------

;; Write backups to ~/.emacs.d/backup/
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old


;;------------------------------------------------------------------------------
;; Package Manager Initialization (Straight.el)
;;------------------------------------------------------------------------------

;; Bootstrapping Straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Turn off built-in package.el to prevent download collisions
(setq package-enable-at-startup nil)

;; Tells use-package to automatically use straight.el instead of package.el!
(defvar straight-use-package-by-default)
(setq straight-use-package-by-default t)

(declare-function straight-use-package "straight")
(straight-use-package 'use-package)

(eval-when-compile
  (require 'use-package))


;;------------------------------------------------------------------------------
;; Prevents ~/.emacs.d/ from being treated as a project
;;------------------------------------------------------------------------------

(declare-function project-try-vc "project")
(declare-function project-try-vc-except-emacsd "project")

(with-eval-after-load 'project
  ;; remove the default unrestricted Git finder
  (remove-hook 'project-find-functions #'project-try-vc)

  ;; create a wrapper that filters out .emacs.d paths
  (defun project-try-vc-except-emacsd (dir)
    (let ((expanded-dir (expand-file-name dir)))
      ;; check if ".emacs.d" is anywhere in the directory path string
      (unless (string-match-p "/\\.emacs\\.d\\(?:/\\|$\\)" expanded-dir)
        ;; fall back to the standard Git detection if it's safe
        (project-try-vc dir))))

  ;; add the safe wrapper to project.el
  (add-hook 'project-find-functions #'project-try-vc-except-emacsd))

;; force the *scratch* buffer to live in the user home
(with-current-buffer "*scratch*"
  (setq default-directory (expand-file-name "~/")))


;;------------------------------------------------------------------------------
;; Expanded Configuration Files Loading Sequence
;;------------------------------------------------------------------------------

;; Use "y/n" instead of "yes/no" for confirmation prompts
(setopt use-short-answers t)

;; Explicitly force dev-core.el to load FIRST so shared tools are active
(load "~/.emacs.d/elisp/developer/dev-core.el")

;; Load remaining custom files safely
(mapc 'load (file-expand-wildcards "~/.emacs.d/elisp/custom-themes/*.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/elisp/developer/*.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/elisp/*.el"))


;;------------------------------------------------------------------------------
;; Removes any package not activelly in use to keep Emacs installation clean
;;------------------------------------------------------------------------------

(add-hook 'emacs-startup-hook
          (lambda ()
            (require 'package)
            (unless package--initialized (package-initialize))
            (package-autoremove)))


(provide 'init)
;;; init.el ends here
