execute pathogen#infect()

syntax on
filetype plugin indent on
set tabstop=2 shiftwidth=2 expandtab
set ignorecase
set smartcase
set hlsearch

set foldmethod=syntax
set nofoldenable

set nu
set wildmode=longest,list,full
set wildmenu

nnoremap tl  :tabnext<CR>
nnoremap th  :tabprev<CR>

set omnifunc=syntaxcomplete#Complete

"Fancy IDE style completion options
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-n>\<C-y>" : "\<CR>" 
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1

inoremap <C-@> <C-x><C-o>

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

inoremap jk <ESC>
