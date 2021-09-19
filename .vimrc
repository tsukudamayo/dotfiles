" syntax on
set nu

" filepath to save file backup undo swp  file
set backupdir=~/.vim/backup
set directory=~/.vim/swp
set undodir=~/.vim/undo

" set encofing fileencoding
set encoding=utf-8
set fileencodings=utf-8,sjis,cp932,utf-16,utf-16le,utf-16be
set fileformats=unix,dos,mac

" settings indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" settings BSkey
set backspace=indent,eol,start

" settings clipboard
set clipboard=unnamed,autoselect

set foldmethod=indent

" settings indent by filetype
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.md setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.rst setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cs setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END
