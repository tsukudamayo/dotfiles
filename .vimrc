syntax on
set nu

"インデントの設定
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

"BSキーが使用できなくなってしまったため、追加
set backspace=indent,eol,start

"ファイル別のインデントの設定
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py     setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb     setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.html   setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.md     setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"dein.vim(インストールできていない)
"if &compatible
"    set nocompatible
"endif
"
"set runtimepath^=~/dotfiles/.vim/dein/repos/github.com/Shougo/dein.vim
"
"call dein#begin(expand('~/dotfiles/.vim/dein'))
"
"call dein#add('Shougo/dein.vim')
"call dein#add('plasticboy/vim-markdown')
"call dein#add('kannokanno/previm')
"call dein#add('tyru/open-browser.vim')
"
"call dein#end()
"
"filetype plugin indent on
"

"NeoBundle(dein.vimの設定ができなかったので)
if 0 | endif

if &compatible
    set nocompatible
endif

set runtimepath^=~/dotfiles/.vim/bundle/neobundle.vim

call neobundle#begin(expand('~/dotfiles/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

"Markdownプラグインのためのコマンドのエイリアスの設定
:command Pvo PrevimOpen

