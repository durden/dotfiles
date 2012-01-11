set lines=90
set columns=90
set colorcolumn=80

filetype on
filetype plugin on
filetype plugin indent on

" Open a file in the same directory of the open file, regardless of
" the directory you spawned vim from
map <Leader>ew :tabnew <C-R>=expand("%:p:h") . "/" <CR>

" Shortcut for browsing and opening new tab
map <Leader>btn :browse tabnew<CR>

" Easier copy/paste from system clipboard
map <Leader>cp "+gP
map <Leader>cy "+y

" Shortcut for opening new tab with file
map <Leader>tn :tabnew

map <C-Up> :tabnext<CR>
map <C-Down> :tabprev<CR>
