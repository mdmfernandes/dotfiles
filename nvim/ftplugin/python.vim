""" Execute the Python script
map <Leader>x :!python3 %<CR>

""" Fixers for python
let g:ale_fixers = {
\   'python': ['isort', 'remove_trailing_lines', 'reorder-python-imports', 'yapf'],
\}

""" Linters for python
let g:ale_linters = {
\    'python': ['flake8', 'pylint'],
\}
