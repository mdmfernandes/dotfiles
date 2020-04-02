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
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'neoclide/coc.nvim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vimwiki/vimwiki'

call vundle#end()
filetype plugin on
""" Vundle (end)

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


""" coc.vim
call coc#add_extension('coc-json', 'coc-python', 'coc-snippets', 'coc-markdownlint', 'coc-pairs', 'coc-prettier')
" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup

" Better display for messages
"set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
"set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rw <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> \a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> \e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> \c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> \o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> \s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> \j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> \k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> \p  :<C-u>CocListResume<CR>
""" coc.vim (end)


""" vim-gitgutter
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

