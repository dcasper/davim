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
Plug 'sainnhe/everforest'
Plug 'sainnhe/gruvbox-material'

Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'

Plug 'godlygeek/tabular'
"Plug 'preservim/vim-markdown'
"let g:markdown_folding = 1
Plug 'psf/black'

"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'rickhowe/diffchar.vim'
Plug 'prabirshrestha/vim-lsp'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1

if executable('typescript-language-server')
  augroup LspTypeScript
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'typescript-language-server',
          \ 'cmd': {server_info -> ['typescript-language-server', '--stdio']},
          \ 'allowlist': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
          \ })
  augroup END
endif

augroup LspConfig
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

augroup LspDiff
  autocmd!
  autocmd BufEnter,WinEnter * if &diff | call lsp#disable_diagnostics_for_buffer(bufnr('%')) | endif
augroup END

set signcolumn=no

function! s:on_lsp_buffer_enabled() abort

  setlocal omnifunc=lsp#complete

  set completeopt=menu,menuone,noinsert

  "if !&diff
  "  setlocal foldmethod=expr
  "  setlocal foldexpr=lsp#ui#vim#folding#foldexpr()
  "  setlocal foldtext=lsp#ui#vim#folding#foldtext()
  "  setlocal foldlevel=99
  "endif

  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gD <plug>(lsp-declaration)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gy <plug>(lsp-peek-type-definition)
  nmap <buffer> gY <plug>(lsp-type-definition)

  nmap <buffer> K <plug>(lsp-hover)

  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> <leader>ca <plug>(lsp-code-action)

  nmap <buffer> [d <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]d <plug>(lsp-next-diagnostic)
endfunction

set termguicolors

syntax on
filetype plugin indent on
set tabstop=2 shiftwidth=2 expandtab
set ignorecase
set smartcase
set hlsearch

set foldmethod=syntax
set foldlevel=99

function! MyFoldText()
  let first = substitute(getline(v:foldstart), '\s\+$', '', '')
  let count = v:foldend - v:foldstart + 1
  return printf('%s  ▸ %d lines',
        \ substitute(getline(v:foldstart), '\s\+$', '', ''), 
        \ v:foldend - v:foldstart + 1
        \ )
endfunction

set foldtext=MyFoldText()

function! SetFoldLevel(level)
  normal! zM
  execute 'setlocal foldlevel=' . a:level
endfunction

nnoremap z1 :call SetFoldLevel(1)<CR>
nnoremap z2 :call SetFoldLevel(2)<CR>
nnoremap z3 :call SetFoldLevel(3)<CR>
nnoremap z4 :call SetFoldLevel(4)<CR>
nnoremap z5 :call SetFoldLevel(5)<CR>
nnoremap z6 :call SetFoldLevel(6)<CR>

set nu
set wildmode=longest,list,full
set wildmenu

set backspace=indent,eol,start

"Wheel scrolling: n = normal mode only, so : and insert mode leave the pointer to the terminal
set mouse=n

"Tab Navigation
nnoremap tl  gt
nnoremap th  gT

inoremap <C-@> <C-x><C-o>

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

augroup diffcolors
    autocmd!
    autocmd Colorscheme * call s:SetDiffHighlights()
augroup END

function! s:SetDiffHighlights()
    if &background == "dark"
        highlight DiffAdd gui=bold guifg=NONE guibg=#2e4b2e
        highlight DiffDelete gui=bold guifg=NONE guibg=#4c1e15
        highlight DiffChange gui=bold guifg=NONE guibg=#45565c
        "highlight DiffText gui=bold guifg=NONE guibg=#996d74
        highlight DiffText gui=bold guifg=NONE guibg=#5a4548
    else
        highlight DiffAdd gui=bold guifg=NONE guibg=palegreen
        highlight DiffDelete gui=bold guifg=NONE guibg=tomato
        highlight DiffChange gui=bold guifg=NONE guibg=lightblue
        highlight DiffText gui=bold guifg=NONE guibg=lightpink
    endif
endfunction

set background=dark
"colorscheme jellybeans
"colorscheme everforest
colorscheme gruvbox-material

highlight LineNr ctermfg=79

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

command! Glow silent %w !glow -t -w $(tput cols) -

"vimdiff config
set diffopt+=algorithm:histogram
set diffopt+=indent-heuristic
set fillchars=diff:░

nnoremap <C-P> :GitFiles<CR>
nnoremap <C-L> :History<CR>

let g:fzf_layout = {
      \ 'window': {
      \   'width': 0.9,
      \   'height': 0.7,
      \ }
      \ }
