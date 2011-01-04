" -*- coding: utf-8 -*-
"
" Copyright (c) 2009, 2010 Johan Liseborn <johan.liseborn@gmail.com>
"
" Permission to use, copy, modify, and/or distribute this software for any
" purpose with or without fee is hereby granted, provided that the above
" copyright notice and this permission notice appear in all copies.
"
" THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
" WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
" MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
" ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
" WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
" ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
" OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
"
" Based on the example vimrc file by Bram Moolenaar.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set smartcase           " smart case searching
set number              " show line numbers
set sessionoptions+=resize,unix,slash

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Setup tabbing
set sw=4
set sts=4
set expandtab
set smarttab

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  set ofu=syntaxcomplete#Complete

  " Makefile settingss....
  autocmd FileType make setlocal noexpandtab sw=8 sts=8
 
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Remvove trailing whitespace
  autocmd BufWritePre *.py :%s/\s\+$//e

  " Remove trailing ^M
  autocmd BufEnter *.py :%s/[ \t\r]\+$//e
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Setup a pretty status line
set statusline=%F%m%r%h%w%=[%{&ff}]\ [%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" Automatically reload changed files
set autoread

let mapleader = ","
"let maplocalleader = ","

" Python
let python_highlight_all = 1
autocmd FileType python set omnifunc=pythoncomplete#Complete

" SuperTab
let g:SuperTabDefaultCompletionType='context' 
let g:SuperTabRetainCompletionDuration='completion'
" let g:SuperTabContextDefaultCompletionType='context'

" Clojure
let vimclojure#WantNailgun = 1
let g:clj_highlight_builtins = 1
let g:clj_paren_rainbow = 1

" Tasklist
map T :TaskList<CR>
map P :TlistToggle<CR>

" Fuzzy
map <leader>b :FufBuffer<CR>
map <leader>f :FufFile<CR>
map <leader>m :FufMruFile<CR>
" map <leader>t :FufTag<CR>
let g:fuf_modesDisable = [ 'mrucmd', ]

" NERD Tree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" Folding
" nnoremap <space> za
" vnoremap <space> zf

