;; -*- mode: emacs-lisp; coding: utf-8 -*-

;; Copyright (c) 2009, Johan Liseborn <johan.liseborn@gmail.com>
;;
;; Permission to use, copy, modify, and/or distribute this software for any
;; purpose with or without fee is hereby granted, provided that the above
;; copyright notice and this permission notice appear in all copies.
;;
;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

;;; A nice startup message...
(defun superjudge-reloaded ()
  (animate-string
   (concat
    ";;                                                  8\n"
    ";;                                                  8\n"
    ";; .oPYo. 8    8 .oPYo. .oPYo. 8oPYo. 8 8    8 .oPYo8 .oPYo. .oPYo.\n"
    ";; Yb..   8    8 8    8 8oooo8 8'     8 8    8 8    8 8    8 8oooo8\n"
    ";;   'Yb. 8    8 8    8 8.     8      8 8    8 8    8 8    8 8\n"
    ";; 'YooP' 'YooP' 8YooP' 'Yooo' 8      8 'YooP' 'YooP' 'YooP8 'YooP'\n"
    ";; ......:......:8......:.....:......:8........:......:...:8.:....:\n"
    ";; ::::::::::::::8:::::::::::::::'YooP':::::::::::::::'YooP':::::::\n"
    ";; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n\n"
    ";; Initialization successful. Welcome to "
    (substring (emacs-version) 0 16)
    ".")
   0 0)
  (end-of-buffer)
  (newline-and-indent)
  (newline-and-indent))

(add-hook 'after-init-hook 'superjudge-reloaded)

(global-auto-revert-mode)

;; Setup pretty colors...
(zenburn)

;; Turn on font-lock for a bunch of programming modes
;; (add-hook 'python-mode-hook 'turn-on-font-lock)
(add-hook 'python-mode-hook '(lambda () (setq show-trailing-whitespace t)))
;; (add-hook 'c++-mode-hook 'turn-on-font-lock)
;; (add-hook 'c-mode-hook 'turn-on-font-lock)
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
(add-hook 'emacs-lisp-mode-hook '(lambda () (setq show-trailing-whitespace t)))
;; (add-hook 'shell-script-mode-hook 'turn-on-font-lock)
;; (add-hook 'cperl-mode-hook 'turn-on-font-lock)
;; (add-hook 'html-mode-hook 'turn-on-font-lock)
;; (add-hook 'LaTeX-mode-hook 'turn-on-font-lock)
;; (add-hook 'java-mode-hook 'turn-on-font-lock)
;; (add-hook 'php-mode-hook 'turn-on-font-lock)
;; (add-hook 'write-file-hook 'time-stamp)

;; Window switching
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window 2)))

;; Load some games
(require 'sudoku)
