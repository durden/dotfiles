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
set background=dark
colorscheme wwdc-2016
" Other nice color schemes
" base16-eighties
" dracula

set ruler
set hls
set guifont=Inconsolata:h12

call pathogen#infect()

" Go-specific plugins
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim

filetype on
filetype plugin indent on

" Turn on completion for python since it's included in vim 7.3
autocmd FileType python runtime! autoload/pythoncomplete.vim

" Keep backup files in one location so their easier to find
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp

"------------------------------- SPACING -------------------------------------
set tw=79       " text width
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

" Tell Ack vim plugin to highlight the search term
let g:ackhighlight = 1

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

" Show current file in Marked.app
:nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>

" Enable 'pretty paste' mode when copying with mouse to avoid crazy indentation
map <Leader>mp :set paste<CR>

" Disable 'pretty paste' mode so auto-indent works again
map <Leader>nmp :set nopaste<CR>

" Toggle syntax checking (it can be slow on files with lots of python imports)
map <Leader>tsc :SyntasticToggleMode<CR>

" Force check of syntax
map <Leader>fsc :SyntasticCheck<CR>

" Use flake8 instead of pylint b/c it's faster (although checks less stuff)
let g:syntastic_python_checkers = ['flake8']

" Dash search
map <Leader>d <Plug>DashSearch

" Codrspace script
map <leader>c :! codrspace_import '%:p'<cr>

" Pretty format json
map <leader>json :%!python -m json.tool<cr>


"---------------------------------- PLUGINS ----------------------------------

" Google's yapf python formatter
map <Leader>p8 :call yapf#YAPF()<cr>

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

" Ignore project_files/ for ctrl-p
set wildignore+=*/project_files/*
set wildignore+=*/.ropeproject/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/.pyc


" From: https://gist.github.com/aroben/d54d002269d9c39f0d5c89d910f7307e 
" Put this in your .vimrc and whenever you `git commit` you'll see the diff of
" your commit next to your commit message.
" For the most accurate diffs, use `git config --global commit.verbose true`

" BufRead seems more appropriate here but for some reason the final `wincmd p`
" doesn't work if we do that.
autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
function OpenCommitMessageDiff()
  " Save the contents of the z register
  let old_z = getreg("z")
  let old_z_type = getregtype("z")

  set colorcolumn=50,72

  try
    call cursor(1, 0)
    let diff_start = search("^diff --git")
    if diff_start == 0
      " There's no diff in the commit message; generate our own.
      let @z = system("git diff --cached -M -C")
    else
      " Yank diff from the bottom of the commit message into the z register
      :.,$yank z
      call cursor(1, 0)
    endif

    " Paste into a new buffer
    vnew
    normal! V"zP
  finally
    " Restore the z register
    call setreg("z", old_z, old_z_type)
  endtry

  " Configure the buffer
  set filetype=diff noswapfile nomodified readonly
  silent file [Changes\ to\ be\ committed]

  " Get back to the commit message
  wincmd p
endfunction
