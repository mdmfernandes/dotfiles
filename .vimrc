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
Plugin 'morhetz/gruvbox'
" - tabline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" - git
Plugin 'airblade/vim-gitgutter'
" - others
Plugin 'scrooloose/nerdtree'
Plugin 'dense-analysis/ale'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin on
""" Vundle (end)

""" Syntax highlighting
syntax on

""" Displayed encoding
set encoding=utf-8

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
set updatetime=250  " Change the update time of signs
"" Custom key bindings
" Hunk-add and hunk-revert for hunk staging
nmap <Leader>ga <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
" Jump between hunks
nmap <Leader>gn <Plug>(GitGutterNextHunk)
nmap <Leader>gp <Plug>(GitGutterPrevHunk)
" Preview hunk changes
nmap <Leader>gv <Plug>(GitGutterPreviewHunk)
nmap <Leader>gd :pclose<CR>
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

""" ALE
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%] %s [%code%]'
"" Signs
let g:ale_sign_error = '●'
let g:ale_sign_warning = '○'
highlight ALEErrorSign ctermfg=124 ctermbg=bg
highlight ALEWarningSign cterm=bold ctermfg=172 ctermbg=bg
"" Navigation keys
nmap <Leader>ln <Plug>(ale_next_wrap)
nmap <Leader>lp <Plug>(ale_previous_wrap)
nmap <Leader>lg <Plug>(ale_first)
nmap <Leader>lG <Plug>(ale_last)
nmap <Leader>lv <Plug>(ale_detail)
""" ale (end)

""" nerdtree
map <C-t> :NERDTreeToggle<CR>
""" nerdtree (end)

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
" Leader
map <Space> <Leader>
" Toogle line wrapping
map <F6> <Esc>:set wrap!<CR>
" Open file under the cursor in a new tab
map <Leader>o <Esc><C-W>gF<CR>:tabm<CR>
" base64 decode the word under cursor
nmap <Leader>b :!echo <C-R><C-W> \| base64 -d<CR>
" Buffers
map <Leader>n :bn<CR>
map <Leader>p :bp<CR>
map <Leader>d :bd<CR>
map <Leader>v :buffers<CR>
" Tabs
map <C-n> <Esc>:tabe<CR>
map <C-h> gT
map <C-l> gt
" Hide search highlights
nnoremap <silent> <Esc><Esc> :nohls<CR>
" Toggle between paste and nopaste modes
set pastetoggle=<F3>

""" Change commands
" Write current file with sudo perms
command! W w

""" Make backspace a bit nicer
set backspace=eol,start,indent

""" Visual prompt for command completion
set wildmenu

""" Enable jumping into files in a search buffer
set hidden

""" Splits open to right and bottom
set splitbelow
set splitright

