;; -*- Mode: Emacs-Lisp -*-

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

(require 'color-theme)
(color-theme-comidia)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; A nice startup message
(defun emacs-reloaded ()
  (animate-string (concat ";; Initialization successful. Welcome to "
                          (substring (emacs-version) 0 16)
                          ".")
                  0 1)
  (newline-and-indent)
  (newline-and-indent)
  ;; We do not like sloppy whitespace
  (setq-default show-trailing-whitespace t))
(add-hook 'after-init-hook 'emacs-reloaded)

;;; Turn on font-lock for a bunch of programming modes
(add-hook 'c++-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
(add-hook 'shell-script-mode-hook 'turn-on-font-lock)
(add-hook 'cperl-mode-hook 'turn-on-font-lock)
(add-hook 'python-mode-hook 'turn-on-font-lock)
(add-hook 'html-mode-hook 'turn-on-font-lock)
(add-hook 'LaTeX-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'turn-on-font-lock)
(add-hook 'php-mode-hook 'turn-on-font-lock)
(add-hook 'write-file-hook 'time-stamp)

(diary)
(require 'erc)
(column-number-mode t)
;(auto-compression-mode t)
(iswitchb-mode t)

;;; Indent using spaces only
(setq-default indent-tabs-mode t)

;;; Visible bell only
(setq visible-bell t)

;;; Provide a useful error trace if init fails
(setq debug-on-error t)

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
(blink-cursor-mode nil)

;;; Set so when moving by page, last visible line is highlighted.
;(load "highlight-context-line.el")

;;; Completion ignore-list
(setq completion-ignored-extensions
      '(".o" ".elc" ".class" "java~" ".ps" ".abs" ".mx" ".~jv" ".pyc" ))

;;; Compile init.el if needed
(defun autocompile nil
  "compile itself if ~/.emacs.d/init.el"
  (interactive)
  (require 'bytecomp)
  (if (string= (buffer-file-name)
               (expand-file-name (concat default-directory "init.el")))
      (byte-compile-file (buffer-file-name))))

(add-hook 'after-save-hook 'autocompile)

;(require 'jde)

;;; Clojure mode
;(add-to-list 'load-path "~/work/lisp/clojure-mode")
;(require 'clojure-auto)
;(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
;(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;;; Slime
;(add-to-list 'load-path "~/work/lisp/slime/")
;(add-to-list 'load-path "~/work/lisp/slime/contrib")
;(require 'slime)
;(slime-setup '(slime-repl))

;;; Clojure Swank
;(add-to-list 'load-path "~/work/lisp/swank-clojure")
;(setq swank-clojure-binary "/Users/mjl/bin/clj")
;(setq swank-clojure-jar-path "/Users/mjl/work/lisp/clojure-read-only/clojure.jar")
;alternatively, you can set up the clojure wrapper script and use that: 
;(setq swank-clojure-extra-classpaths (list "/Users/mjl/work/lisp/programming-clojure"))
;(setq swank-clojure-extra-vm-args "-server -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8888")
;(require 'swank-clojure-autoload)

;; To use other Lisps...
;; Incidentally, you can then choose different Lisps with
;;   M-- M-x slime <tab>
;(add-to-list 'slime-lisp-implementations
;             '(sbcl   ("/opt/local/bin/sbcl")))

;;; Set-up Erlang mode
;(setq load-path (cons "/opt/local/lib/erlang/lib/tools-2.6.2/emacs" load-path))
;(setq erlang-root-dir "/opt/local/lib/erlang")
;(setq exec-path (cons "/opt/local/lib/erlang/bin" exec-path))
;(require 'erlang-start)

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

;; start the server for emacsclient
(server-start)

(setq debug-on-error nil) ;was set t at top of buffer
