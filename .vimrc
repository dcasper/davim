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

command RmSpaces :%s/\s\+$/

map <C-H> :execute "tabmove" tabpagenr() - 2 <CR>
map <C-L> :execute "tabmove" tabpagenr() <CR>

" Set Shell to use bash instead of zsh
set shell=zsh

nnoremap <silent> <Leader>= :12winc +<CR>
nnoremap <silent> <Leader>- :12winc -<CR>
nnoremap <silent> <Leader>, :20winc <<CR>
nnoremap <silent> <Leader>. :20winc ><CR>

map <C-S> :call RunCurrentSpecFile()<CR>

nmap <space> zz
colorscheme jellybeans
highlight LineNr ctermfg=79

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
