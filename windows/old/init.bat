git config --global user.email "v_mayo.tukuda@pactera.com"
git config --global user.name "tsukuda"

set PATH=%PATH%;%HOMEPATH%\bin
set PATH=%PATH%;%HOMEPATH%\lib\tsukudaoriginal

:golang
set PATH=%PATH%;%HOMEPATH%\tools\Go\bin
set PATH=%PATH%;%HOMEPATH%\go\bin

:java
set PATH=%PATH%;%HOMEPATH%\tools\Java\jdk1.8.0_231\bin
:java_home
set JAVA_HOME=C:\Users\tsukuda\tools\Java\jdk1.8.0_231
:gradle
set PATH=%PATH%;C:\Gradle\gradle-6.2.2\bin

:scala
set PATH=%PATH%;%HOMEPATH%\tools\scala\bin
:sbt
set PATH=%PATH%;%HOMEPATH%\tools\sbt\bin

:hadoop_spark
set HADOOP_HOME=C:\Users\tsukuda\tools\spark-2.4.4-bin-hadoop2.7
set SPARK_HOME=C:\Users\tsukuda\tools\spark-2.4.4-bin-hadoop2.7
set PATH=%PATH%;C:\Users\tsukuda\tools\spark-2.4.4-bin-hadoop2.7\bin
set PYSPARK_PYTHON=C:\Users\tsukuda\tools\Miniconda3\\envs\mongodb-sample\python.exe
set PYSPARK_DRIVER_PYTHON=jupyter
set PYSPARK_DRIVER_PYTHON_OPTS=notebook
set PYSPARK_SUBMIT_ARGS="pyspark-shell"

:nodejs complete
set PATH=%PATH%;%HOMEPATH%\tools\nodejs
:yarn
set PATH=%PATH%;%HOMEPATH%\tools\Yarn\bin

:ruby
set PATH=%PATH%;%HOMEPATH%\tools\Ruby25-x64\bin

:perl
set PATH=%PATH%;C:\Perl64\bin

:python requirements.txt
set CONDA_FORCE_32BIT=
copy %HOMEPATH%\dotfiles\windows\requirements.txt %HOMEPATH%\etc

:clisp
set PATH=%PATH%;%HOMEPATH%\lib\roswell

:R
set PATH=%PATH%;%HOMEPATH%\tools\R-3.6.0\bin\x64

:julia
set PATH=%PATH%;%HOMEPATH%\tools\Julia-1.1.0\bin

:rust
set PATH=%PATH%;%HOMEPATH%\.cargo\bin

:make
set PATH=%PATH%;%HOMEPATH%\tools\GnuWin32\bin


:tools
set PATH=%PATH%;%HOMEPATH%\tools\7-Zip
set PATH=%PATH%;%HOMEPATH%\tools\rlogin

:emacs
set PATH=%PATH%;%HOMEPATH%\tools\emacs-26.1\bin

:vim
set PATH=%PATH%;%HOMEPATH%\tools\vim\src
copy %HOMEPATH%\dotfiles\.vimrc %HOMEPATH%\

:cmder config file
copy %HOMEPATH%\dotfiles\windows\ConEmu.xml %HOMEPATH%\tools\cmder\vendor\conemu-maximus5

:putty
set PATH=%PATH%;%HOMEPATH%\tools\PuTTY

:teraterm
set PATH=%PATH%;%HOMEPATH%\tools\teraterm

:cabocha
set PATH=%PATH%;C:\Program Files (x86)\CaboCha\bin

:juman
set PATH=%PATH%;%HOMEPATH%\tools\juman

:knp
set PATH=%PATH%;%HOMEPATH%\tools\knp

:mecab
set PATH=%PATH%;C:\Program Files (x86)\MeCab\bin

:llvm
set PATH=%PATH%;%HOMEPATH%\tools\LLVM\bin

:cmake
set PATH=%PATH%;%HOMEPATH%\tools\CMake\bin

:graphviz
set PATH=%PATH%;%HOMEPATH%\tools\Miniconda3\envs\jpnlp32\Library\bin\graphviz

:dockertoolbox
rem set PATH=%PATH%;C:\"Program Files"\"Docker Toolbox"

:docker_for_windows
set PATH=%PATH%;C:\"Program Files"\Docker\Docker\resources\bin
:virtualbox
set PATH=%PATH%;C:\Program Files\Oracle\VirtualBox

:kubectl
set PATH=%PATH%;%HOMEPATH%\tools\kubectl

:protoc
set PATH=%PATH%;%HOMEPATH%\tools\protoc\bin

:webprotoc
set PATH=%PATH%;%HOMEPATH%\tools\web-grpc-1.0.6

:ginza
set PATH=%PATH%;%HOMEPATH%\tools\Miniconda3\envs\ginza\Lib\site-packages\ja_ginza

:kytea
set PATH=%PATH%;%HOMEPATH%\local\nlp_learning_for_python\recipe_nlp\kytea-win-0.4.2

:openssl
set PATH=%PATH%;%HOMEPATH%\tools\OpenSSL-Win32\bin

:helm
set PATH=%PATH%;%HOMEPATH%\tools\helm-v3.0.0-rc.1-windows-amd64\windows-amd64

:WaImportExportV1
set PATH=%PATH%;%HOMEPATH%\tools\WaImportExportV1

:mongodb
set PATH=%PATH%;C:\"Program Files"\MongoDB\Server\4.2\bin

:mysql
set PATH=%PATH%;C:\"Program Files"\MySQL\"MySQL Server 5.6"\bin

:roswell
set PATH=%PATH%;%HOMEPATH%\tools\roswell

:msbuild
C:\"Program Files (x86)"\"Microsoft Visual Studio"\2017\Community\VC\Auxiliary\Build\vcvars64.bat
