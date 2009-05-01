;; -*- Mode: Emacs-Lisp; Coding: utf-8 -*-

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

;;; Provide a useful error trace if init fails
(setq debug-on-error t)

;; (if (require 'color-theme nil t)
;;     (progn
;;       (color-theme-initialize)
;;       (color-theme-comidia)))

;;; Set local load path...
(add-to-list 'load-path "~/local/share/emacs/site-lisp/")

;;; Put custom.el in emacs.d...
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; A nice startup message...
(defun emacs-reloaded ()
  (animate-string (concat ";; Initialization successful. Welcome to "
                          (substring (emacs-version) 0 16)
                          ".")
                  0 1)
  (newline-and-indent)
  (newline-and-indent))
(add-hook 'after-init-hook 'emacs-reloaded)
(add-hook 'after-init-hook 'server-start)

;;; Setup encoding for international
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)

;;; Turn on font-lock for a bunch of programming modes
(add-hook 'c++-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
(add-hook 'shell-script-mode-hook 'turn-on-font-lock)
(add-hook 'cperl-mode-hook 'turn-on-font-lock)
(add-hook 'python-mode-hook 'turn-on-font-lock)
(add-hook 'python-mode-hook '(lambda () (setq show-trailing-whitespace t)))
(add-hook 'html-mode-hook 'turn-on-font-lock)
(add-hook 'LaTeX-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'turn-on-font-lock)
(add-hook 'php-mode-hook 'turn-on-font-lock)
(add-hook 'write-file-hook 'time-stamp)

;;; Calendar & Time stuff...
(setq calendar-latitude 59.3)
(setq calendar-longitude 18.4)
(setq calendar-location-name "Gustavsberg, Sweden")
;(setq timeclock-modeline-display t)

(setq diary-file "~/.diary")
(diary)
(require 'erc)
(column-number-mode t)
;(auto-compression-mode t)
(iswitchb-mode t)
(winner-mode )

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;;; Indent using spaces only
(setq-default indent-tabs-mode t)

;;; Visible bell only
(setq visible-bell t)

;;; Set abbrevs file name and auto-save
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
;;(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))
(setq save-abbrevs t)

;;; Turn off the status bar if we're not in a window system
;(menu-bar-mode (if window-system 1 -1))

;;; Accelerate the cursor when scrolling.
(load "accel" t t)

;;; Start scrolling when 2 lines from top/bottom
;(setq scroll-margin 2)
;(setq scroll-step 1)

;;; Set so when moving by page, last visible line is highlighted.
;(load "highlight-context-line.el")

;;; Completion ignore-list
(setq completion-ignored-extensions
      '(".o" ".elc" ".class" "java~" ".ps" ".abs" ".mx" ".~jv" ".pyc" ))

;;; Compile init.el if needed
;; (defun autocompile nil
;;   "compile itself if ~/.emacs.d/init.el"
;;   (interactive)
;;   (require 'bytecomp)
;;   (if (string= (buffer-file-name)
;;                (expand-file-name (concat default-directory "init.el")))
;;       (byte-compile-file (buffer-file-name))))

;; (add-hook 'after-save-hook 'autocompile)

;(require 'jde)

;;; Setup Slime
(add-to-list 'load-path "~/local/share/emacs/site-lisp/slime/")
(add-to-list 'load-path "~/local/share/emacs/site-lisp/slime/contrib/")
;(add-to-list 'load-path "~/work/lisp/slime/")
;(add-to-list 'load-path "~/work/lisp/slime/contrib")
(if (require 'slime nil t)
    (slime-setup '(slime-repl)))

;;; Clojure mode
(add-to-list 'load-path "~/local/share/emacs/site-lisp/clojure-mode/")
;(add-to-list 'load-path "~/work/lisp/clojure-mode")
(if (require 'clojure-auto nil t)
    (progn (autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
	   (add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))))

;;; Clojure Swank
(add-to-list 'load-path "~/local/share/emacs/site-lisp/swank-clojure/")
;(add-to-list 'load-path "~/work/lisp/swank-clojure")
(setq swank-clojure-binary "~/bin/clj")
(setq swank-clojure-jar-path "~/work/lisp/clojure-read-only/clojure.jar")
;;alternatively, you can set up the clojure wrapper script and use that:
(setq swank-clojure-extra-classpaths (list "~/work/lisp/programming-clojure"))
(setq swank-clojure-extra-vm-args "-server -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8888")
(require 'swank-clojure-autoload nil t)

;; To use other Lisps...
;; Incidentally, you can then choose different Lisps with
;;   M-- M-x slime <tab>
(add-to-list 'slime-lisp-implementations
             '(sbcl   ("/opt/local/bin/sbcl")))

;;; Set-up Erlang mode
(add-to-list 'load-path "~/local/share/emacs/site-lisp/erlang/")
;(setq load-path (cons "/opt/local/lib/erlang/lib/tools-2.6.2/emacs" load-path))
(setq erlang-root-dir "/opt/local/lib/erlang")
(setq exec-path (cons "/opt/local/lib/erlang/bin" exec-path))
(require 'erlang-start nil t)

;;; Setup Haskell
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$" . haskell-mode)
                ("\\.hi$" . haskell-mode)
                ("\\.l[hg]s$" . haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
  "Major mode for editing literate Haskell scripts." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'turn-on-font-lock)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Desktop restore
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'desktop)

(setq history-length 100)
(add-to-list 'desktop-globals-to-save 'file-name-history)
(add-to-list 'desktop-globals-to-save 'vc-comment-ring)
(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'erc-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(setq desktop-files-not-to-save "\\(^/[^/:]*:\\|bbdb\\)")

(setq debug-on-error nil) ; was set t at top of buffer
