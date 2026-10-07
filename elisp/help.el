;;; help.el --- Cheatsheet for Org-Mode -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Help Message with Keybindings References for Org-Mode
;;------------------------------------------------------------------------------

(defun emacs-org-custom-help ()
  "Create a new readonly buffer with help information about the mapped shortcuts."
  (interactive)
  (split-window-right)
  (select-window (previous-window))
  (switch-to-buffer "emacs-org-custom-help")
  (emacs-org-custom-help-mode)
  (emacs-org-custom-help-init)
  (select-window (previous-window)))

(define-derived-mode emacs-org-custom-help-mode special-mode "emacs-org-custom-help")

(defun emacs-org-custom-help-init ()
  "Displays the Org-Mode sheetcheat in a split window."
  (let ((inhibit-read-only t))
      (erase-buffer)
      (insert "\n[[ Org-Mode :: Useful Key Bindings ]]\n")
      (insert "+---------------+----------------------------------------------------------------+\n")
      (insert "|                             GENERAL ORG SHORTCUTS                              |\n")
      (insert "|---------------+----------------------------------------------------------------|\n")
      (insert "|               |                                                                |\n")
      (insert "| Shift-<TAB>   | cycle through the header visibility states                     |\n")
      (insert "| C-<RET>       | creates a new header at the current level                      |\n")
      (insert "| C-c l         | copy the link of the current section of the document           |\n")
      (insert "| C-c C-l       | insert or edit a link in a document                            |\n")
      (insert "| C-c C-o       | opens the link below the cursor on the default browser         |\n")
      (insert "| C-c .         | insert timestamp at current cursor position                    |\n")
      (insert "| C-c C-,       | insert custom block of text                                    |\n")
      (insert "| C-c C-e       | export the document on the chosen format                       |\n")
      (insert "|               |                                                                |\n")
      (insert "+---------------+----------------------------------------------------------------+\n")
      (insert "|                       PROJECT / DOCUMENTATION MANAGEMENT                       |\n")
      (insert "+---------------+----------------------------------------------------------------+\n")
      (insert "|               |                                                                |\n")
      (insert "| C-Shift-<RET> | creates a new todo header at the current level                 |\n")
      (insert "| C-c C-t       | cycle between todo states in a header                          |\n")
      (insert "| Shift-<LEFT>  |                                                                |\n")
      (insert "| Shift-<RIGHT> |                                                                |\n")
      (insert "|               |                                                                |\n")
      (insert "| Shift-UP      | increase priority for the current reader                       |\n")
      (insert "| Shift-DOWN    | decrease priority for the current reader                       |\n")
      (insert "| C-c a t       | navigate through the global todo list                          |\n")
      (insert "|               |                                                                |\n")
      (insert "| C-c C-s       | set the scheduled date for a given header                      |\n")
      (insert "| C-c C-d       | set the deadline date for a given header                       |\n")
      (insert "|               |                                                                |\n")
      (insert "| C-c C-, s     | insert new CODE BLOCK in the document                          |\n")
      (insert "| C-c C-c       | run CODE BLOCK / toggle checklist                              |\n")
      (insert "|               |                                                                |\n")
      (insert "| C-c C-v f     | tangle code blocks to file, ask to chose location              |\n")
      (insert "| C-c C-v t     | tangle code blocks to file, specified on #+PROPERTY doc header |\n")
      (insert "|               | (#+PROPERTY: header-args :tangle ~/tmp/test.rs)                |\n")
      (insert "|               | (#+BEGIN_SRC rust        :tangle ~/tmp/single.rs)              |\n")
      (insert "|               |                                                                |\n")
      (insert "| C-c C-e h h   | Export .org document to .html                                  |\n")
      (insert "| C-c C-e h o   | Export .org document to .html and opens on the browser         |\n")
      (insert "|               |                                                                |\n")
      (insert "+---------------+----------------------------------------------------------------+\n")
      (insert "|                               TIME MANAGEMENT                                  |\n")
      (insert "+---------------+----------------------------------------------------------------+\n")
      (insert "|                      |                                                         |\n")
      (insert "| C-c C-x C-i          | clock in (on the current section/project)               |\n")
      (insert "| C-c C-x C-o          | clock out (on the current section/project)              |\n")
      (insert "| C-c C-x C-j          | jump cursor to the most recent clock                    |\n")
      (insert "| C-c C-c              | update current clock/report                             |\n")
      (insert "| M-x org-clock-report | create table with report of all hours in all projects   |\n")
      (insert "|                      |                                                         |\n")
      (insert "| C-c a a              | opens org-agenda for the current week/day               |\n")
      (insert "|                      |                                                         |\n")
      (insert "+---------------+----------------------------------------------------------------+\n")))


(global-set-key (kbd "C-c o h") 'emacs-org-custom-help)


(provide 'help)
;;; help.el ends here
