" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocp

"-------------------------- GENERAL OPTIONS ----------------------------------
set showcmd
set showmatch   " show matching opening bracket/paren. when closing
set incsearch   " incremental search
syntax on
set nu
colorscheme desert
set ruler
set hls
set guifont=Inconsolata:h14
filetype plugin on

" Keep backup files in one location so their easier to find
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp


"------------------------------- SPACING -------------------------------------
set tw=79       " tab width
set ts=4        " tab stop
set sw=4        " shift width
set sts=4
set expandtab
set wiw=80
set bs=2        " allow backspacing over everything in insert mode
set autoindent  " always set autoindenting on

"------------------------------ MAPPINGS -------------------------------------
" Open a file in the same directory of the open file, regardless of the
" directory you spawned vim from
map <Leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>

" Run pep8 plugin on current file
map <Leader>pep :call Pep8()<CR>

" Possible way to do it with autocmd so that it only shows up for python files?
"autocmd FileType python nnoremap <buffer> <Leader> :call Pep8()<CR> 

"---------------------------------- PLUGINS ----------------------------------
source ~/.vim/plugin/supertab.vim
