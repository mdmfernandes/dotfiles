""" VIM Configs
set nocompatible

" Specify the plugins directory
call plug#begin('~/.vim/plugged')

" Plugins
" - themes
Plug 'morhetz/gruvbox'
" - tabline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" - git
Plug 'airblade/vim-gitgutter'
" - others
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vimwiki/vimwiki'
Plug 'dense-analysis/ale'

call plug#end()

"filetype plugin on

""" Syntax highlighting
syntax on

""" Enable jumping into files in a search buffer
set hidden

""" Displayed encoding
set encoding=utf-8

""" Signs refresh time
set updatetime=250  

" Map Leader
let mapleader = "\<Space>"

"---------- Plugins ----------
""" gruvbox
set background=dark 
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
""" gruvbox (end)


""" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'powerlineish'
""" vim-airline (end)


""" vim-gitgutter
"" Custom key bindings
" Hunk-add and hunk-revert for hunk staging
nmap ga <Plug>(GitGutterStageHunk)
nmap gu <Plug>(GitGutterUndoHunk)
" Jump between hunks
nmap gn <Plug>(GitGutterNextHunk)
nmap gp <Plug>(GitGutterPrevHunk)
" Preview hunk changes
nmap gv <Plug>(GitGutterPreviewHunk)
nmap gd :pclose<CR>
"" Custom signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
"" Signs' background color
let g:gitgutter_override_sign_column_highlight = 1
highlight GitGutterAdd cterm=bold ctermfg=106 ctermbg=bg
highlight GitGutterDelete cterm=bold ctermfg=124 ctermbg=bg
highlight GitGutterChange cterm=bold ctermfg=172 ctermbg=bg
""" vim-gitgutter (end)


""" nerdtree
map <C-t> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules$']
""" nerdtree (end)


""" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
""" ctrlp (end)


""" VimWiki
let g:vimwiki_list = [{'path': '~/Documents/VimWiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
""" VimWiki (end)


""" ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%][%linter%] %s'
""" ALE (end)

""" History
set history=50 "default

""" Display
set ls=2            "default
set showmode        "default
set showcmd         " Show commands on bottom right corner
set ruler           " Show the ruler on the right side of the status line
set title
set nu              " Show line numbers

""" Hybrid Line numbers
set number relativenumber

""" Line wrapping
set wrap        " wrap lines
set linebreak
set showbreak=▹ " Show this symbol at break lines

"" Direction keys for wrapped lines
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

""" Indentation
set autoindent  " Auto indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab

""" Disable mouse
set mouse=

""" Searching
set ignorecase
set smartcase   " Only ignore case if the search pattern is all in lowercase
set hlsearch    " Highlight all found patterns
set showmatch   " When a bracket is inserted, briefly jump to the matching one

""" Map keys
" Toogle line wrapping
map <F6> <Esc>:set wrap!<CR>
" Open file under the cursor in a new tab
map <Leader>o <Esc><C-W>gF<CR>:tabm<CR>
" base64 decode the word under cursor
nmap <Leader>64 :!echo <C-R><C-W> \| base64 -d<CR>
" Buffers
map <Leader>b :enew<CR>
map <Leader>n :bn<CR>
map <Leader>p :bp<CR>
map <Leader>d :bd<CR>
map <Leader>l :buffers<CR>
" Tabs
map <C-n> <Esc>:tabe<CR>
map <C-h> gT
map <C-l> gt
" Hide search highlights
nnoremap <silent> <Leader><Space> :nohls<CR>
" Toggle between paste and nopaste modes
set pastetoggle=<F3>

""" Change commands
" Write current file with sudo perms
command! W w

""" Make backspace a bit nicer
set backspace=eol,start,indent

""" Visual prompt for command completion
set wildmenu

""" Splits open to right and bottom
set splitbelow
set splitright

