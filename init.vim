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
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Doesn't seem to work with snippets and LCN, see https://github.com/autozimu/LanguageClient-neovim/issues/379
"Plug 'roxma/nvim-completion-manager' "ncm is rip, https://github.com/roxma/nvim-completion-manager/issues/12#issuecomment-382334422
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-ultisnips'
" Neosnippet provides the [ ] in completion
" I want to remove this somehow
" Note: neosnippet has a nasty bug with lcn
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
" cpsm completion NOTE: boost needed
Plug 'nixprime/cpsm', {
    \ 'do': 'bash install.sh',
    \ }
""""""" File man | UI
" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Defx seems nice but setup is a pain...
"Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
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
""""""" Swap/ Utility
" autoswap
Plug 'gioele/vim-autoswap'
""""""" Theme
" Badwolf
Plug 'sjl/badwolf'
""""""" Syntastic 'fork'
" No clue what has to be setup
"Plug 'neomake/neomake'
""""""" Languages
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'PY3=ON bash install.sh',
    \ }
"""" Rust
" Rust syntax
Plug 'rust-lang/rust.vim'
" Racer
Plug 'racer-rust/vim-racer'
" racer for ncm
Plug 'ncm2/ncm2-racer'
""""""""" Lisp
"parinfer in rust, "smart edit"
Plug 'eraserhd/parinfer-rust'
"""" Tmux / Screen
Plug 'ervandew/screen'
" Fancy icons
" takes a lot of gbs
Plug 'ryanoasis/vim-devicons'
" Better nvim terminal
Plug 'mklabs/split-term.vim'
call plug#end()
colorscheme badwolf
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""" 
" start deoplete
"let g:deoplete#enable_at_startup = 1
" Disable the candidates in Comment/String syntaxes.
"call deoplete#custom#source('_',
            "\ 'disabled_syntaxes', ['Comment', 'String'])
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
"set delay
"call deoplete#custom#option('auto_complete_delay', 200)
"""""""""""" ncm2
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

set hidden
let mapleader=","
set number
set mouse=a
"""""""" RLS
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
" viminfo deprecated, use shada instead
"set viminfo^=%
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
"imap <c-j>	<Plug>(neosnippet_expand_or_jump)
"vmap <c-j>	<Plug>(neosnippet_expand_or_jump)
"inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
"vmap <c-u>	<Plug>(neosnippet_expand_target)
"let g:neosnippet#enable_completed_snippet=1
"" ultisnips

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" deoplete
"let g:deoplete#enable_at_startup = 1

" delimitMate
au FileType rust let b:delimitMate_balance_matchpairs = 1
au FileType rust let b:delimitMate_expand_cr = 1
au FileType python,rust let b:delimitMate_nesting_quotes = ['"']
" ScreenShell settings
let g:ScreenImpl = 'Tmux'
" split-term settings
set splitbelow

