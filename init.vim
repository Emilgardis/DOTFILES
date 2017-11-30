" NVIM rc
" Install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"
call plug#begin()


""""""" Completion
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-completion-manager'
" Neosnippet provides the [ ] in completion
" I want to remove this somehow
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
""""""" File man | UI
" NERDTree
Plug 'scrooloose/nerdtree'
" Multi-entry selection UI.
Plug 'junegunn/fzf'
" Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'
" git diff
Plug 'airblade/vim-gitgutter'
" unite all interfaces (?)
"Plug 'Shougo/denite.nvim'
" Airline
Plug 'vim-airline/vim-airline'
""""""" Theme
" Badwolf
Plug 'sjl/badwolf'
""""""" Syntastic 'fork'
" No clue what has to be setup
"Plug 'neomake/neomake'
""""""" Languages
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
"""" Rust
" Rust syntax
Plug 'rust-lang/rust.vim'
" Racer
Plug 'racer-rust/vim-racer'
" racer for ncm
Plug 'roxma/nvim-cm-racer'
" 
call plug#end()
colorscheme badwolf
" RLS
set hidden
let mapleader=","
set number
set mouse=a
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> ga :call LanguageClient_textDocument_codeAction()<CR>
nnoremap <silent> <F3> :call LanguageClient_textDocument_rename()<CR>

" Enable tabline
let g:airline#extensions#tabline#enabled = 1

" Move a line of text using ALT+[up,down] or Comamnd+[up,down] on mac
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <M-down> mz:m+<cr>`z
nmap <M-up> mz:m-2<cr>`z
vmap <M-down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-up> :m'<-2<cr>`>my`<mzgv`yo`z

" replace selection with buffer(https://stackoverflow.com/a/920139/4284367)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap r "_dP

" set D to d blackhole register
"""""""""""""""""""""""""""""""
noremap D "_d

" Switch tabs/buffers quickly, with window support
"""""""""""""""""""""""""""""""""""""""""""""
map <TAB> :tabn<CR>
map <S-TAB> :tabp<CR>

map <silent> <S-left> :bp<CR>
map <silent> <S-right> :bn<CR>

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


" Return to last edit position when opening files (You want this!)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
"""""""""""""""""""""""""""""""""""""""""""
set viminfo^=%

" NERDTree
""""""""""
" Load on open, kinda annoying.
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"autocmd BufEnter * NERDTreeMirror
map <leader>k :NERDTreeFind<cr>
map <leader>l :NERDTreeToggle<cr>

""Set F2 to put the cursor to the nerdtree
nmap <silent> <F2> :NERDTreeFind<CR>

" Close with last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" neosnippet
imap <c-j>	<Plug>(neosnippet_expand_or_jump)
vmap <c-j>	<Plug>(neosnippet_expand_or_jump)
inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
vmap <c-u>	<Plug>(neosnippet_expand_target)
let g:neosnippet#enable_completed_snippet=1
"let g:deoplete#enable_at_startup = 1

" delimitMate
au FileType rust let b:delimitMate_balance_matchpairs = 1
au FileType rust let b:delimitMate_expand_cr = 1
au FileType python,rust let b:delimitMate_nesting_quotes = ['"']
