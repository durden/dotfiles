"-------------------------- GENERAL OPTIONS ----------------------------------
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocp
set showcmd     " Show command in window
set showmatch   " show matching opening bracket/paren. when closing
set incsearch   " incremental search
set wildmenu    " Additional help when tabbing directories, etc.
syntax on
set nu
colorscheme desert
set ruler
set hls
set guifont=Inconsolata:Medium:9

call pathogen#infect()

filetype on
filetype plugin indent on

" Turn on completion for python since it's included in vim 7.3
autocmd FileType python runtime! autoload/pythoncomplete.vim

" Keep backup files in one location so their easier to find
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp

" Ctags
set tags=~/projects/git_pyqt/mytags

"------------------------------- SPACING -------------------------------------
set tw=79       " tab width
set ts=4        " tab stop
set sw=4        " shift width
set sts=4
set expandtab
set shiftround  " Round indents to multiple of shift width
set wiw=80
set bs=2        " allow backspacing over everything in insert mode
set autoindent  " always set autoindenting on

"------------------------------ MAPPINGS -------------------------------------
" Reaching for Esc is annoying
inoremap kk <Esc>

" Open a file in the same directory of the open file, regardless of the
" directory you spawned vim from
map <Leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>

" Run pep8 plugin on current file
let g:pep8_map='<Leader>pep'

" Turn on relative line numbering, for easy copy/paste of chunks of lines
map <Leader>rel :set relativenumber<CR>
" Turn off relative line numbering
map <Leader>nrel :set nu<CR>

" Hide search highlighted text
map <Leader> :nohl<CR>

" Possible way to do it with autocmd so that it only shows up for python files?
"autocmd FileType python nnoremap <buffer> <Leader> :call Pep8()<CR>

" Trim trailing whitespace from file
map <Leader>trim :%s/\s\+$//<CR>:w<CR>

" Insert new line above current without leaving command mode
map <S-Enter> O<Esc>

" Insert new line below current without leaving command mode
map <CR> o<Esc>

" Insert the currently yanked text onto a new line above
map <Leader>P <S-Enter>P

" Insert the currently yanked text onto a new line below
map <Leader>p <CR>p
"---------------------------------- PLUGINS ----------------------------------

" Use gundo to look at local file change tree
map <Leader>g :GundoToggle<CR>

" Jump back in the tag stack with this instead of CTRL-T b/c other plugins like
" ctrlp remaps this already
map <Leader>pt :pop<CR>

" Don't let pyflakes use the quickfix window b/c it breaks it when you try to
" navigate pep8 (or other things)
let g:pyflakes_use_quickfix = 0

" Python-mode settings
" Disable automatic code folding
let g:pymode_folding = 0

" Don't run lint on all saves
let g:pymode_lint_write = 0

" Don't automatically remove all trailing whitespace
let g:pymode_utils_whitespaces = 0

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" http://stackoverflow.com/questions/3105307/how-do-you-automatically-remove
" -the-preview-window-after-autocompletion-in-vim
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
