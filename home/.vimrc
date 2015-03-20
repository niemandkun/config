" Vim config file "

colorscheme jellybeans
syntax on
set number

set guioptions=m
set guifont=Terminus\ 12
"set guifont=PT\ Mono\ 11
"set guifont=Envy\ Code\ R\ 11
set winminheight=0

set ignorecase
set incsearch
set autoindent

set tabstop=4
set shiftwidth=4
set expandtab

set iskeyword=@,48-57,_,192-255
set linebreak
set dy=lastline

" python special "
" remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e
" highlight overlength lines
highlight OverLength ctermfg=red guifg=red
match OverLength /\%80v.*/

set mouse=a
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

imap <F2> <Esc>:w<CR>
map <F2> <Esc>:w<CR>

imap <F3> <Esc>:read
map <F3> <Esc>:read

imap <F4> <Esc>:browse tabnew<CR>
map <F4> <Esc>:browse tabnew<CR>

imap <F5> <Esc> :tabprev <CR>i
map <F5> :tabprev <CR>

imap <F6> <Esc> :tabnext <CR>i
map <F6> :tabnext <CR>

set wildmenu
set wcm=<Tab>
menu Exit.quit     :quit<CR>
menu Exit.quit!    :quit!<CR>
menu Exit.save     :exit<CR>
map <F10> :emenu Exit.<Tab>

set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r  :e ++enc=koi8-r<CR>
menu Encoding.cp1251  :e ++enc=cp1251<CR>
menu Encoding.cp1252  :e ++enc=cp1252<CR>
menu Encoding.cp866   :e ++enc=cp866<CR>
menu Encoding.ucs-2le :e ++enc=ucs-2le<CR>
menu Encoding.utf-8   :e ++enc=utf-8<CR>
map <F9> :emenu Encoding.<Tab>
