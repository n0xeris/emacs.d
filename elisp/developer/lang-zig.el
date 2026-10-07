;;; lang-zig.el --- Zig Configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:


;;------------------------------------------------------------------------------
;; Zig Configuration
;;------------------------------------------------------------------------------

(use-package zig-mode
  :ensure t
  :hook (zig-mode . lsp-deferred)
  :custom
  (zig-indent-offset 4)
  (zig-format-on-save t))


(provide 'lang-zig)
;;; lang-zig.el ends here
