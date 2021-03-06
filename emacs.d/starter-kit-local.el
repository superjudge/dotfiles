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

(set-default-font "-apple-Inconsolata-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
(set-language-environment "utf-8")

;;; Setup pretty colors
(load-theme 'wombat)
;; (setq dotfiles-dir (file-name-directory
;;                     (or (buffer-file-name) load-file-name)))
;; (setq user-specific-dir (concat dotfiles-dir user-login-name))
;; (add-to-list 'load-path (concat user-specific-dir "/color-theme"))
;; (add-to-list 'load-path (concat user-specific-dir "/emacs-color-theme-solarized"))
;; (require 'color-theme)
;; (require 'color-theme-solarized)
;; (color-theme-solarized-dark)
;(require 'color-theme)
;(zenburn)
;(color-theme-twilight)

;; Color Theme
;; (setq dotfiles-dir (file-name-directory
;;                     (or (buffer-file-name) load-file-name)))
;; (setq user-specific-dir (concat dotfiles-dir user-login-name))
;; (add-to-list 'load-path (concat user-specific-dir "/color-theme"))
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      (color-theme-taylor)))

;;; Some global defaults
(column-number-mode t)
(line-number-mode t)
(global-auto-revert-mode t)
;(tool-bar-mode -1)
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

;;; Org-mode
(setq org-agenda-files (list "~/.org/work.org"
                             "~/.org/home.org"))

;;; Sensible screen splitting
(setq split-width-threshold nil)

;;; Global key mappings
(global-set-key (kbd "M-p") 'magit-status)
(global-set-key (kbd "C-<tab>") 'hippie-expand)

(add-to-list 'load-path "~/local/otp/R14B/lib/erlang/lib/tools-2.6.6.4/emacs")
;(require 'erlang-start)
;(require 'erlang-flymake)
;(require 'linum)
;(require 'slime-autoloads)

;;; Scala
;(add-to-list 'load-path "~/local/elisp/scala-mode")
;(require 'scala-mode-auto)

;;; Haskell
;(load "~/local/elisp/haskellmode-emacs/haskell-site-file")

;;; Gambit Scheme
;(add-to-list 'load-path "~/local/share/gambit/site-lisp")
;(require 'gambit)

;;; Common Lisp
(load (expand-file-name "~/quicklisp/slime-helper.el"))

(require 'slime)

(setq common-lisp-hyperspec-root
      "file:///~/local/share/HyperSpec")
;(add-to-list 'slime-lisp-implementations
;             '(ccl64 ("~/bin/ccl64" "-K utf-8")))
(add-to-list 'slime-lisp-implementations
             '(clisp ("clisp")))
(add-to-list 'slime-lisp-implementations
             '(sbcl ("sbcl" "--sbcl-nolineedit")))
(add-to-list 'slime-lisp-implementations
             '(cmucl ("lisp")))

(setq slime-net-coding-system 'utf-8-unix)
(slime-setup '(slime-fancy))

;;; Code mode hooks
(defun turn-on-linum ()
  (linum-mode t))

(defun turn-on-highlight-80+ ()
  (highlight-80+-mode t))

(defun turn-on-trailing-whitespace ()
  (setq show-trailing-whitespace t))

(defun my-erlang-mode-hook ()
  (when (locate-library "erlang-flymake")
    (local-set-key (kbd "M-'") 'erlang-flymake-next-error)
    (local-set-key (kbd "M-/") 'erl-complete)))

(require 'whitespace)
(setq whitespace-line-column 78)

;;; Appand these (as font-lock sometimes breaks on large
;;; files, and then these will never be invoked)
(add-hook 'coding-hook 'turn-on-linum t)
;(add-hook 'coding-hook 'turn-on-trailing-whitespace t)
(add-hook 'coding-hook 'whitespace-mode t)
(add-hook 'coding-hook 'turn-on-highlight-80+ t)

(add-hook 'clojure-mode-hook 'turn-on-linum t)
(add-hook 'clojure-mode-hook 'whitespace-mode t)
(add-hook 'clojure-mode-hook 'turn-on-highlight-80+ t)

(add-hook 'python-mode-hook 'run-coding-hook)
(add-hook 'haskell-mode-hook 'run-coding-hook)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'erlang-mode-hook 'run-coding-hook)
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
;; (add-hook 'write-file-hook 'time-stamp)

(add-hook 'lisp-interaction-mode (lambda () (paredit-mode +1)))

;;; TODO: We should really look at what our project looks like,
;;;       and adapth the code and include paths accordingly...
;;;       For now we just assume that we have a set of application
;;;       directories...
(defun add-code-postfix (path)
  (concat path "/ebin"))

(defun add-include-postfix (path)
  (concat path "/include"))

;; (defun my-erlang-flymake-get-code-path-dirs ()
;;   (mapcar 'add-code-postfix
;;           (directory-files (concat  (erlang-flymake-get-app-dir) "../") t "^[^\.]")))

;; (defun my-erlang-flymake-get-include-dirs ()
;;   (mapcar 'add-include-postfix
;;           (directory-files (concat (erlang-flymake-get-app-dir) "../") t "^[^\.]")))

;; Setup Erlang flymake for Nitrogen project structures
(defun my-erlang-flymake-get-code-path-dirs ()
  (interactive)
  (list
   (concat (erlang-flymake-get-app-dir) "../ebin")))

(defun my-erlang-flymake-get-include-dirs ()
  (interactive)
  (append
   (mapcar 'add-include-postfix
           (directory-files (concat (erlang-flymake-get-app-dir) "../lib/") t "^[^\.]"))
   (list
    (concat (erlang-flymake-get-app-dir) "../include"))))

;; (setq erlang-flymake-get-code-path-dirs-function
;;   'my-erlang-flymake-get-code-path-dirs)

;; (setq erlang-flymake-get-include-dirs-function
;;   'my-erlang-flymake-get-include-dirs)

(defun r13b ()
  (setq erlang-root-dir (expand-file-name "~/local/otp/R13B04"))
  (add-to-list 'exec-path (expand-file-name "~/local/otp/R13B04/bin"))
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

(setq inferior-erlang-machine-options '("-sname" "emacs@localhost"))
(defvar inferior-erlang-prompt-timeout t)
(setq erl-nodename-cache 'emacs@localhost)

;;; Setup Distel
(when (file-accessible-directory-p "~/src/distel")
  (add-to-list 'load-path "~/src/distel/elisp")
  (require 'distel)
  (distel-setup))

;;; Setup Wrangler
(when (file-accessible-directory-p "/usr/local/share/wrangler/elisp")
  (add-to-list 'load-path "/usr/local/share/wrangler/elisp")
  (require 'wrangler))

;; (require 'worklog)
;; (setq worklog-automatic-login t)
;; (add-hook 'emacs-startup-hook
;;           (function (lambda ()
;;                       (worklog-do-task "Hacking emacs" t))))

;; (add-hook 'kill-emacs-hook
;;           (function (lambda ()
;;                       (worklog-do-task "logout" t)
;;                       (worklog-finish))))

;(require 'save-visited-files)
;(turn-on-save-visited-files-mode)

;;; Darwin
(when (eq system-type 'darwin)
  (setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
  (push "/usr/local/bin" exec-path)
  ;; Make the mac-alt key work as normal. Mac-option becomes the meta key
  (setq mac-option-key-is-meta nil)
  (setq mac-command-key-is-meta t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  ;;
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'none)
  (setq default-cursor-type 'box)
  (menu-bar-mode 1))
