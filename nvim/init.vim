""" VIM Configs
set nocompatible

" Specify the plugins directory
call plug#begin('~/.config/nvim/plugged')

" Plugins
" - themes
Plug 'joshdick/onedark.vim'
" - tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" - icons
Plug 'ryanoasis/vim-devicons'
" - git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" - fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" - others
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'dense-analysis/ale'

call plug#end()

"filetype plugin on

""" Enable jumping into files in a search buffer
set hidden

""" Displayed encoding
"set encoding=utf-8

""" Signs refresh time
set updatetime=250  

" Map Leader
let mapleader = "\<Space>"

" --------- Themes -----------
""" Tabline
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'wombat'
let g:airline_powerline_fonts = 1

""" Theme
syntax on
"set termguicolors
set background=dark 
colorscheme onedark

"---------- Plugins ----------
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
nnoremap <silent> <C-t> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeIgnore = ['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', 'node_modules']
let g:NERDTreeChDirMode=2
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
""" nerdtree (end)


""" fzf
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>g :Commits<CR>
""" fzf (end)


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
set showbreak=▶ " Show this symbol at break lines

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
map <Leader>c :enew<CR>
map <Leader>n :bn<CR>
map <Leader>b :bp<CR>
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
" Copy/paste to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

""" Change commands
" Write current file with sudo perms
command! W w

""" Splits open to right and bottom
set splitbelow
set splitright

""" Save swap and backup files to /tmp
set directory=/tmp
set backupdir=/tmp
