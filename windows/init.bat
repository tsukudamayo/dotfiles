mkdir %HOMEPATH%\.vimfiles
mkdir %HOMEPATH%\.vimfiles\undo
mkdir %HOMEPATH%\.vimfiles\backup
mkdir %HOMEPATH%\.vimfiles\swp

copy %HOMEPATH%\dotfiles\.vimrc %HOMEPATH%\.vimrc

set PATH=C:\Users\USER\opt\emacs\bin;%PATH%
set PATH=C:\msys64\mingw32\bin;%PATH%
set PATH=C:\msys64\mingw64\bin;%PATH%
set PATH=C:\msys64\usr\bin;%PATH%
set PATH=C:\Windows\Microsoft.NET\Framework64\v4.0.30319;%PATH%
set PATH=C:\Users\USER\opt\vim\src;%PATH%

C:\Users\USER\tools\"Microsoft Visual Studio"\2017\Community\VC\Auxiliary\Build\vcvarsall amd64
