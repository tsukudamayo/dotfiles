mkdir %HOMEPATH%\vimfiles
mkdir %HOMEPATH%\vimfiles\undo
mkdir %HOMEPATH%\vimfiles\backup
mkdir %HOMEPATH%\vimfiles\swp

mkdir %HOMEPATH%\AppData\Roaming\.emacs.d
mkdir %HOMEPATH%\AppData\Roaming\.emacs.d\backup

copy %HOMEPATH%\dotfiles\.vimrc %HOMEPATH%\.vimrc
copy %HOMEPATH%\dotfiles\windows\.emacs %HOMEPATH%\AppData\Roaming\.emacs

:bin
set PATH=%HOMEPATH%\bin;%PATH%

:msys2
set PATH=C:\msys64\mingw32\bin;%PATH%
set PATH=C:\msys64\mingw64\bin;%PATH%
set PATH=C:\msys64\usr\bin;%PATH%

:CMake
set PATH=%HOMEPATH%\tools\CMake\bin;%PATH%

:LLVM 
:Clang
set PATH=%HOMEPATH%\tools\LLVM\bin;%PATH%

:ImageMagick
set PATH=%HOMEPATH%\tools\ImageMagick;%PATH%

:rust
set PATH=%HOMEPATH%\.cargo\bin;%PATH%

:NET
set PATH=C:\Windows\Microsoft.NET\Framework64\v4.0.30319;%PATH%

:Java
set PATH=%HOMEPATH%\tools\Java\jdk-10.0.1\bin;%PATH%
set PATH=%HOMEPATH%\tools\apache-maven-3.5.3\bin;%PATH%
set PATH=%HOMEPATH%\tools\gradle-4.7-all\gradle-4.7\bin;%PATH%
echo %JAVA_HOME%

:Go
set PATH=%GOPATH%\bin;%PATH%
set PATH=%HOMEPATH%\tools\Go\bin;%PATH%

:editor
set PATH=%HOMEPATH%\opt\emacs\bin;%PATH%
set PATH=%HOMEPATH%\opt\vim\src;%PATH%

:kubectl
set PATH=%HOMEPATH%\tools\kubectl;%PATH%

:node
set PATH=%HOMEPATH%\AppData\Roaming\npm\node_modules;%PATH%

:VisualStudio
%HOMEPATH%\tools\"Microsoft Visual Studio"\2017\Community\VC\Auxiliary\Build\vcvarsall amd64
