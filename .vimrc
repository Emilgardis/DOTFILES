set nocompatible
filetype off
set backspace=indent,eol,start
"" Source .vimrc after save
"augroup reload_vimrc " {
"    autocmd!
"    autocmd BufWritePost $MYVIMRC source $MYVIMRC augroup END " }
"" Vundle Initialization and loading.
"""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'drmikehenry/vim-fixkey'
Plugin 'Valloric/YouCompleteMe'
Plugin 'shougo/neocomplete.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'
Plugin 'shougo/unite.vim'
Plugin 'racer-rust/vim-racer'
"Plugin 'cybeliak/vim-plugin-minibufexpl'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'kana/vim-submode'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'scrooloose/nerdtree'
call vundle#end()
"" Vundle
"""""""""

let g:ycm_collect_identifiers_from_tags_files = 1


"" General
""""""""""
filetype plugin indent on
syntax enable
let mapleader = ","
set mouse=a

set tags=./tags;,tags;
set updatetime=250
set wildmenu
set wildignore=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg
set hlsearch
set incsearch
set lazyredraw
set number
"" Text
"""""""
set encoding=utf8
colorscheme badwolf

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set ai "Auto Indent"
set si "Smart Indent"
set wrap "Wrap Lines"

"" Visual mode
" Visual mode pressing * or # searches for the current selection
" By Michael Naumann
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

""" Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""
" Use correct scheme for new files
""""""
set hidden

" Makes longlines 'break' when moving
"""""""""""""""""""""""""""""""""""""
map <C-Down> gj
imap <C-Down> <C-o>gj
map <C-Up> gk
imap <C-Up> <C-o>gk

" map <Space> to (search) and Ctrl-<Space> to(backward-search) 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <space> /
map <c-space> ?

" Remove highlight with <leader><cr> (Ctrl-enter)
"""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader><cr> :noh<cr>

" Better way to switch window
"""""""""""""""""""""""""""""
map <C-down> <C-w>j
map <C-up> <C-w>k
map <C-left> <C-w>h
map <C-right> <C-w>l
imap <C-w> <C-o><C-w>
nnoremap c<C-down> :bel sp new<cr>
nnoremap c<C-up> :abo sp new<cr>
nnoremap c<C-left> :lefta vsp new<cr>
nnoremap c<C-right> :rightb vsp new<cr>
nnoremap g<C-down> <C-w>j<C-w>_
nnoremap g<C-up> <C-w>k<C-w>_
nnoremap g<C-left> <C-w>h<C-w>_
nnoremap g<C-right> <C-w>l<C-w>_
nnoremap d<C-down> <C-w>j<C-w>c
nnoremap d<C-up> <C-w>k<C-w>c
nnoremap d<C-left> <C-w>h<C-w>c
nnoremap d<C-right> <C-w>l<C-w>c

" Open a new tab with current buffer's path
"""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>te :tabedit <c-r>=expand("%:p:h")<cr><cr>

" Switch tabs/buffers quickly, with window support
"""""""""""""""""""""""""""""""""""""""""""""
map <TAB> :tabn<CR>
map <S-TAB> :tabp<CR>

map <silent> <S-left> :MBEbp<CR>
map <silent> <S-right> :MBEbn<CR>


""" Submode stuff
" don't consume submode-leaving key
let g:submode_keep_leaving_key = 1


" Specify the behavior when switching between buffers 
"""""""""""""""""""""""""""""""""""""""""""""""""""""
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
"""""""""""""""""""""""""""""""""""""""""""
set viminfo^=%

" Move a line of text using ALT+[up,down] or Comamnd+[up,down] on mac
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <M-down> mz:m+<cr>`z
nmap <M-up> mz:m-2<cr>`z
vmap <M-down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-up> :m'<-2<cr>`>my`<mzgv`yo`z

" Neocomplete
"""""""""""""
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" YCM
"""""
" g:ycm_path_to_python_interpreter = "/usr/bin/python2.7"

" Rust config
"""""""""""""
let g:racer_cmd = "/home/localsys/.cargo/bin/racer"
"let $RUST_SRC_PATH="/home/localsys/src/rust/src"
let g:ftplugin_rust_source_path = "/home/localsys/src/rust"
let g:ycm_rust_src_path="/home/localsys/src/rust/src"

" YCM off for Python and C, Neocomplete on.
let g:ycm_filetype_blacklist = {
    \'python': 1,
    \'c': 1,
    \'cpp': 1
\}
autocmd FileType rust NeoCompleteLock

" NERDTree
""""""""""
" Load on open, kinda annoying.
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"autocmd BufEnter * NERDTreeMirror
map <leader>k :NERDTreeFind<cr>
map <leader>l :NERDTreeToggle<cr>


"CTRL-t to toggle tree view with CTRL-t
"nmap <silent> <C-t> :NERDTreeToggle<CR>
""Set F2 to put the cursor to the nerdtree
nmap <silent> <F2> :NERDTreeFind<CR>

" Close with last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
