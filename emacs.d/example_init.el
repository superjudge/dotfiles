;; -*- Mode: Emacs-Lisp -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This is an emacs/xemacs configuration.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(or (boundp 'running-xemacs)
    (defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Path variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst emacs-init-dir  (expand-file-name "~/emacs/")
  "User init directory")

(defconst emacs-etc-dir  (expand-file-name "etc/" emacs-init-dir)
  "User etc directory")

(defconst emacs-lisp-dir  (expand-file-name "lisp/" emacs-init-dir)
  "User lisp directory for el file for both Emacsen")

(defconst emacs-packages-dir  (expand-file-name "packages/" emacs-init-dir)
  "Directory for elisp packages")

(defconst emacs-ewiki-dir  (expand-file-name "emacs-wiki/" emacs-init-dir)
  "Directory for lisp files from the EmacsWiki")

(defconst init-lisp-dir (expand-file-name "init/" emacs-init-dir)
  "Directory for the initialization files")

(defconst emacs-mylisp-dir (expand-file-name "elisp/" emacs-init-dir)
  "Lisp directory for homegrown lispfiles")
                                          
(defconst x-emacs-lisp-dir  (expand-file-name "lisp/" emacs-init-dir)
  "Lisp directory for XEmacs or Emacs, relative to emacs-packages-dir.
holds packages which we need but are missing from the default installation.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(add-to-list 'load-path emacs-init-dir)

;; order matters
(add-to-list 'load-path emacs-packages-dir)
(add-to-list 'load-path emacs-lisp-dir)
(add-to-list 'load-path emacs-mylisp-dir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Info path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'info)
(add-to-list 'Info-default-directory-list "/usr/local/info")
(add-to-list 'Info-default-directory-list "/usr/share/info")
(add-to-list 'Info-default-directory-list (expand-file-name "info/" emacs-init-dir))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; update and load autoloads
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "autoload-make")

(let ((generated-autoload-file (concat emacs-init-dir "autoloads.el")))
  (if (not (file-exists-p generated-autoload-file))
      (update-autoloads-for-lisp-dir)))

(load "autoloads")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load secrets explicitly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load (expand-file-name "secrets.el" emacs-init-dir))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load modules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; load init file if there
(dolist (part '(
                "globals"               ; global initializations
                "edit"           ; edit/typing customisations
                "lisp"           ; lisp functions
                "files"          ; file access functions
                "tex"            ; TeX initialization
                "devel"          ; general development
                "c"              ; C++ development
                "java"           ; Java development
                "sgml"           ; Sgml stuff
                "vc"             ; Version control
                "xref"           ; Xrefactory package
                "www"            ; Web related stuff
                "bbdb"           ; big Brother Insidious Database
                "wiki"           ; wiki stuff
                "calendar"       ; Calendar, planner and Diary
                "gnus"           ; Gnus setup
                "erc"            ; Emacs IRC client
                "multimedia"     ; Music and pictures
                "pilot"          ; pilot sync
                ))
  (load (concat init-lisp-dir part ".el")))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;