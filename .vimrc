let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'nanotech/jellybeans.vim'

Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'

Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

call plug#end()

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

set backspace=indent,eol,start

"Tab Navigation
nnoremap tl  gt
nnoremap th  gT

"Random test comment
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

map <C-H> :tabm -1<CR>
map <C-L> :tabm +1<CR>

" Set Shell to use bash instead of zsh
set shell=zsh

nnoremap <silent> <Leader>= :12winc +<CR>
nnoremap <silent> <Leader>- :12winc -<CR>
nnoremap <silent> <Leader>, :20winc <<CR>
nnoremap <silent> <Leader>. :20winc ><CR>

nmap <space> zz
colorscheme jellybeans
highlight LineNr ctermfg=79

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

let g:jsx_ext_required = 0

let g:rails_projections = {
      \ "app/services/*.rb": {
      \   "command": "services",
      \   "test": "spec/services/{}_spec.rb"
      \ },
      \ "app/drivers/*_driver.rb": {
      \   "command": "drivers",
      \   "test": "spec/drivers/{}_spec.rb"
      \ },
      \ "app/assets/javascripts/components/*.jsx": {
      \   "command": "jcomp",
      \ },
      \ "app/assets/javascripts/stores/*_store.jsx": {
      \   "command": "jstore",
      \ },
      \ "app/assets/javascripts/actions/*_actions.jsx": {
      \   "command": "jaction",
      \ }}

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = 'node_modules'

map <C-S> :Ag<space>

"autocmd BufWritePre *.py silent! execute ':Black'
"autocmd BufWritePre *.js silent! execute ':Prettier'
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
