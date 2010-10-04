;; -*- mode: emacs-lisp; coding: utf-8 -*-

;; Copyright (c) 2009, 2010 Johan Liseborn <johan.liseborn@gmail.com>
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
;; (add-hook 'after-init-hook 'server-start)

;;; Some global defaults
(column-number-mode t)
(line-number-mode t)
(global-auto-revert-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(mouse-avoidance-mode 'cat-and-mouse)

(setq-default indent-tabs-mode nil)

(setq scroll-preserve-screen-position 1)
(setq scroll-conservatively 1)
(setq scroll-margin 5)

(setq make-backup-files nil)
(setq ps-paper-type 'a4)
(setq calendar-week-start-day 1)
(setq european-calendar-style t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date 1)
(display-time-mode)

;;; Bookmarks
(setq bookmark-default-file "~/.emacs.bookmarks"
      bookmark-save-flag 1)

;;; Sensible screen splitting
(setq split-width-threshold nil)

;;; Setup pretty colors
(zenburn)

;;; Global key mappings
(global-set-key (kbd "M-p") 'magit-status)

(require 'linum)
(require 'flymake)

(defun my-code-mode-hook ()
  (setq show-trailing-whitespace t)
  (linum-mode)
  (flymake-mode)
  (highlight-80+-mode))

(defun my-erlang-mode-hook ()
  (my-code-mode-hook)
  (when (locate-library "erlang-flymake")
    (local-set-key (kbd "M-'")
                   'erlang-flymake-next-error)))

(defun my-haskell-mode-hook ()
  (my-code-mode-hook))

(defun my-python-mode-hook ()
  (my-code-mode-hook))

(add-hook 'python-mode-hook 'my-python-mode-hook)
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
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

(setq inferior-erlang-machine-options '("-sname" "emacs@localhost"))

(defun r13b ()
  (setq erlang-root-dir (expand-file-name "~/local/otp/R13B04"))
  (add-to-list 'exec-path (exapnd-file-name "~/local/otp/R13B04/bin"))
  (setq inferior-erlang-machine (expand-file-name "~/local/otp/R13B04/bin/erl")))

(defun r14b ()
  (setq erlang-root-dir (expand-file-name "~/local/otp/R14B"))
  (add-to-list 'exec-path (expand-file-name "~/local/otp/R14B/bin"))
  (setq erlang-man-root-dir (expand-file-name "~/local/otp/R14B/man"))
  (setq inferior-erlang-machine (expand-file-name "~/local/otp/R14B/bin/erl")))

(defun std-erlang ()
  (setq erlang-root-dir "/usr/")
  (setq exec-path (cons "/usr/bin" exec-path))
  (setq inferior-erlang-machine "/usr/bin/erl"))

(r14b)

;;; Setup Distel
(when (file-accessible-directory-p "~/src/distel.git")
  (add-to-list 'load-path "~/src/distel.git/elisp")
  (require 'distel)
  (distel-setup))

;;; Setup Wrangler
(when (file-accessible-directory-p "/usr/local/share/wrangler/elisp")
  (add-to-list 'load-path "/usr/local/share/wrangler/elisp")
  (require 'wrangler))

;; rcirc
;; (require 'rcirc)
;; (add-hook 'rcirc-mode-hook (lambda ()
;;                              (flyspell-mode 1)))
;; (set-face-foreground 'rcirc-my-nick "red" nil)
;; (setq rcirc-time-format "%Y-%m-%d %H:%M")
;; (setq rcirc-default-nick "superjudge")
;; (setq rcirc-default-user-name "superjudge")
;; (setq rcirc-default-user-full-name "Johan Liseborn")
;; (setq rcirc-startup-channels-alist
;;       '(("\\.freenode\\.net" "#emacs" "#rcirc")))

;;; Org mode
(setq org-agenda-files (list "~/.org/work.org"
                             "~/.org/home.org"))

;; Load some games
(require 'sudoku)

;;; Darwin
(when (eq system-type 'darwin)
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'none)
  (menu-bar-mode 1))
