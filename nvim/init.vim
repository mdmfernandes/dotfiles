"##############################################################################
" Miguel's NeoVIM config
" ======================
" Available at https://github.com/mdmfernandes/dotfiles
"##############################################################################

"---------- General ----------
""" Enable filetype detection, plugin, and indent
filetype plugin indent on


set encoding=UTF-8  " Encoding
set updatetime=250  " Signs refresh time
set hidden

""" History
set history=50 "default

""" Display
set ls=2            " (default)
set showmode        " (default)
set showcmd         " Show commands on bottom right corner
set ruler           " Show the ruler on the right side of the status line
set title           " Show window title
set nu              " Show line numbers
syntax on
set background=dark
set scrolloff=10    " Show at least 10 lines above/below the cursor
set cursorline      " Highlight cursor line

""" Hybrid Line numbers
set number relativenumber

""" Line wrapping
set wrap            " wrap lines
set linebreak       " wrap lines at specific characters
set showbreak=▶     " Show this symbol at break lines

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

""" Live highlight substitutions
set inccommand=nosplit

""" Update a file automatically if it changes on the disk
set autoread

""" Splits open to right and bottom
set splitbelow
set splitright

""" Swap and backup files
set nobackup
set noswapfile
set backupdir=/tmp


"---------- Keys ----------
""" Map leader
let mapleader = "\<Space>"

""" Direction keys for wrapped lines
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

""" Navigate Buffers
" Remaining mappins are in the BufferLine configuration file
nnoremap <silent> <C-x> :bdelete<CR>
nnoremap <silent> <Leader>bx :bdelete!<CR>
nnoremap <silent> <Leader>bn :enew<CR>
nnoremap <silent> <Leader>bb :buffers<CR>
nnoremap <silent> <Leader>bz :only<CR>

""" Navigate Tabs
nnoremap <silent> <Leader>tn <Esc>:tabnew<CR>
nnoremap <silent> <Leader>tx <Esc>:tabclose<CR>
nnoremap <silent> <Leader>th <Esc>:tabNext<CR>
nnoremap <silent> <Leader>tl <Esc>:tabnext<CR>

""" Hide search highlights
nnoremap <silent> <Leader><Space> :nohls<CR>

""" Toggle between paste and nopaste modes
set pastetoggle=<F3>

""" Copy/paste to clipboard
nnoremap <Leader>y  "+y
vnoremap <Leader>y  "+y
nnoremap <Leader>Y  "+yg_
nnoremap <Leader>yy "+yy
nnoremap <Leader>p  "+p
vnoremap <Leader>p  "+p
nnoremap <Leader>P  "+P
vnoremap <Leader>P  "+P

""" Show all registers
map <Leader>R :registers<CR>

""" Remap macros recording
noremap <Leader>q q
noremap q <Nop>

""" Toogle line wrapping
map <F6> <Esc> :set wrap!<CR>

""" Load NeoVIM config
nnoremap <Leader><CR> :source ~/.config/nvim/init.vim<CR>

""" Health check
nnoremap <Leader>hc :checkhealth<CR>


"---------- Lua configs ----------
lua require("core")
lua require("plugins")
lua require("lsp")
