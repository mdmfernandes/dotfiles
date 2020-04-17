""" Execute the Python script
map <Leader>x :!python3 %<CR>

""" Fixers for python
let b:ale_fixers = ['isort', 'remove_trailing_lines', 'reorder-python-imports', 'yapf']
