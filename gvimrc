set lines=90
set columns=90

" Open a file in the same directory of the open file, regardless of
" the directory you spawned vim from
map <Leader>ew :tabnew <C-R>=expand("%:p:h") . "/" <CR>

" Shortcut for opening new tab
map <Leader>tn :tabnew
