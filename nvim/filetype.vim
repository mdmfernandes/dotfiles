""" Set filetype based on the file name
" systemd
au BufNewFile,BufRead *.{service,socket,target} setf systemd
