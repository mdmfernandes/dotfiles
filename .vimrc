""" Vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Bundles
" - themes
Plugin 'patstockwell/vim-monokai-tasty'
" - tabline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" - git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" - others
Plugin 'scrooloose/nerdtree'
Plugin 'vimwiki/vimwiki'
"Plugin 'fatih/vim-go'

call vundle#end()
filetype plugin on
""" Vundle (end)

" Syntax highlighting
syntax on

" Displayed encoding
set encoding=utf-8

" Theme config
set background=dark " Dark background
"let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty

" vim-airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'

" History
set history=50 "default

" Display
set ls=2            "default
set showmode        "default
set showcmd         " Show commands on bottom right corner
set ruler           " Show the ruler on the right side of the status line
set title
set nu              " Show line numbers

" Hybrid Line numbers
set number relativenumber

" Line wrapping
set wrap        " wrap lines
set linebreak
set showbreak=▹ " Show this symbol at break lines

" Indentation
set autoindent  " Auto indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab

" Disable mouse
set mouse=

" Searching
set ignorecase
set smartcase   " Only ignore case if the search pattern is all in lowercase
set hlsearch    " Highlight all found patterns
set showmatch   " When a bracket is inserted, briefly jump to the matching one

""" Map some keys
" Toogle line wrapping
map <F6> <Esc>:set wrap!<CR>
" Open file under the cursor in a new line
map <F9> <Esc><C-W>gF<CR>:tabm<CR>
" Switch tabs
map <C-n> <Esc>:tabe
map <C-h> gT
map <C-l> gt

" Direction keys for wrapped lines
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

""" Change some commands
" Write current file with sudo perms
command! W w

" Make backspace a bit nicer
set backspace=eol,start,indent

" Visual prompt for command completion
set wildmenu

" Enable jumping into files in a search buffer
set hidden

" Toggle between paste and nopaste modes
set pastetoggle=<F3>

