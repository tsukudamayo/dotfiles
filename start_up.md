command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

tsukudamayo@tsukudamayo-SVD1121AJ:~$ git
The program 'git' is currently not installed. You can install it by typing:
sudo apt-get install git
tsukudamayo@tsukudamayo-SVD1121AJ:~$ sudo apt-get git
[sudo] password for tsukudamayo: 
E: 不正な操作 git
tsukudamayo@tsukudamayo-SVD1121AJ:~$ sudo apt-get install git
パッケージリストを読み込んでいます... 完了
依存関係ツリーを作成しています                
状態情報を読み取っています... 完了
Package git is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source

E: Package 'git' has no installation candidate
tsukudamayo@tsukudamayo-SVD1121AJ:~$ git
The program 'git' is currently not installed. You can install it by typing:
sudo apt-get install git
tsukudamayo@tsukudamayo-SVD1121AJ:~$ sudo apt-get install git
パッケージリストを読み込んでいます... 完了
依存関係ツリーを作成しています                
状態情報を読み取っています... 完了
Package git is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source

E: Package 'git' has no installation candidate
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ apt-get update
E: ロックファイル /var/lib/apt/lists/lock をオープンできません - open (13: Permission denied)
  E: ディレクトリ /var/lib/apt/lists/ をロックできません
E: ロックファイル /var/lib/dpkg/lock をオープンできません - open (13: Permission denied)
  E: 管理用ディレクトリ (/var/lib/dpkg/) をロックできません。root 権限で実行していますか?
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ sudo apt-get update
  取得:1 http://security.ubuntu.com wily-security InRelease [65.9 kB]            
  取得:2 http://jp.archive.ubuntu.com wily InRelease [218 kB]                    
  取得:3 http://jp.archive.ubuntu.com wily-updates InRelease [65.9 kB]           
  取得:4 http://jp.archive.ubuntu.com wily-backports InRelease [65.9 kB]         
  取得:5 http://jp.archive.ubuntu.com wily/main Sources [1,118 kB]               
  取得:6 http://security.ubuntu.com wily-security/main Sources [50.4 kB]
  取得:7 http://jp.archive.ubuntu.com wily/restricted Sources [7,181 B]          
  取得:8 http://jp.archive.ubuntu.com wily/universe Sources [7,238 kB]           
  取得:9 http://security.ubuntu.com wily-security/restricted Sources [2,854 B]   
  取得:10 http://security.ubuntu.com wily-security/universe Sources [12.9 kB]    
  取得:11 http://security.ubuntu.com wily-security/multiverse Sources [2,789 B]  
  取得:12 http://security.ubuntu.com wily-security/main amd64 Packages [160 kB]  
  取得:13 http://security.ubuntu.com wily-security/restricted amd64 Packages [10.9 kB]
  取得:14 http://security.ubuntu.com wily-security/universe amd64 Packages [53.8 kB]
  取得:15 http://security.ubuntu.com wily-security/multiverse amd64 Packages [6,256 B]
  取得:16 http://security.ubuntu.com wily-security/main i386 Packages [157 kB]   
  取得:17 http://jp.archive.ubuntu.com wily/multiverse Sources [178 kB]          
  取得:18 http://jp.archive.ubuntu.com wily/main amd64 Packages [1,420 kB]       
  取得:19 http://jp.archive.ubuntu.com wily/restricted amd64 Packages [15.6 kB]  
  取得:20 http://jp.archive.ubuntu.com wily/universe amd64 Packages [6,704 kB]   
  取得:21 http://security.ubuntu.com wily-security/restricted i386 Packages [10.8 kB]
  取得:22 http://security.ubuntu.com wily-security/universe i386 Packages [53.9 kB]
  取得:23 http://security.ubuntu.com wily-security/multiverse i386 Packages [6,434 B]
  取得:24 http://security.ubuntu.com wily-security/main Translation-en [77.9 kB] 
  取得:25 http://security.ubuntu.com wily-security/multiverse Translation-en [2,806 B]
  取得:26 http://jp.archive.ubuntu.com wily/multiverse amd64 Packages [138 kB]   
  取得:27 http://jp.archive.ubuntu.com wily/main i386 Packages [1,416 kB]        
  取得:28 http://security.ubuntu.com wily-security/restricted Translation-en [2,666 B]
  取得:29 http://security.ubuntu.com wily-security/universe Translation-en [34.9 kB]
  取得:30 http://jp.archive.ubuntu.com wily/restricted i386 Packages [16.0 kB]   
  取得:31 http://jp.archive.ubuntu.com wily/universe i386 Packages [6,701 kB]    
  取得:32 http://jp.archive.ubuntu.com wily/multiverse i386 Packages [139 kB]    
  取得:33 http://jp.archive.ubuntu.com wily/main Translation-ja [354 kB]         
  取得:34 http://jp.archive.ubuntu.com wily/main Translation-en [839 kB]         
  取得:35 http://jp.archive.ubuntu.com wily/multiverse Translation-ja [8,729 B]  
  取得:36 http://jp.archive.ubuntu.com wily/multiverse Translation-en [107 kB]   
  取得:37 http://jp.archive.ubuntu.com wily/restricted Translation-ja [482 B]    
  取得:38 http://jp.archive.ubuntu.com wily/restricted Translation-en [4,296 B]  
  取得:39 http://jp.archive.ubuntu.com wily/universe Translation-ja [1,091 kB]   
  取得:40 http://jp.archive.ubuntu.com wily/universe Translation-en [4,579 kB]   
  取得:41 http://jp.archive.ubuntu.com wily-updates/main Sources [81.2 kB]       
  取得:42 http://jp.archive.ubuntu.com wily-updates/restricted Sources [3,741 B] 
  取得:43 http://jp.archive.ubuntu.com wily-updates/universe Sources [25.7 kB]   
  取得:44 http://jp.archive.ubuntu.com wily-updates/multiverse Sources [3,196 B] 
  取得:45 http://jp.archive.ubuntu.com wily-updates/main amd64 Packages [225 kB] 
  取得:46 http://jp.archive.ubuntu.com wily-updates/restricted amd64 Packages [13.3 kB]
  取得:47 http://jp.archive.ubuntu.com wily-updates/universe amd64 Packages [99.2 kB]
  取得:48 http://jp.archive.ubuntu.com wily-updates/multiverse amd64 Packages [6,256 B]
  取得:49 http://jp.archive.ubuntu.com wily-updates/main i386 Packages [222 kB]  
  取得:50 http://jp.archive.ubuntu.com wily-updates/restricted i386 Packages [13.4 kB]
  取得:51 http://jp.archive.ubuntu.com wily-updates/universe i386 Packages [96.7 kB]
  取得:52 http://jp.archive.ubuntu.com wily-updates/multiverse i386 Packages [6,687 B]
  取得:53 http://jp.archive.ubuntu.com wily-updates/main Translation-en [105 kB] 
  取得:54 http://jp.archive.ubuntu.com wily-updates/multiverse Translation-en [3,156 B]
  取得:55 http://jp.archive.ubuntu.com wily-updates/restricted Translation-en [3,024 B]
  取得:56 http://jp.archive.ubuntu.com wily-updates/universe Translation-en [56.4 kB]
  取得:57 http://jp.archive.ubuntu.com wily-backports/main Sources [748 B]       
  取得:58 http://jp.archive.ubuntu.com wily-backports/restricted Sources [28 B]  
  取得:59 http://jp.archive.ubuntu.com wily-backports/universe Sources [2,257 B] 
  取得:60 http://jp.archive.ubuntu.com wily-backports/multiverse Sources [28 B]  
  取得:61 http://jp.archive.ubuntu.com wily-backports/main amd64 Packages [619 B]
  取得:62 http://jp.archive.ubuntu.com wily-backports/restricted amd64 Packages [28 B]
  取得:63 http://jp.archive.ubuntu.com wily-backports/universe amd64 Packages [2,006 B]
  取得:64 http://jp.archive.ubuntu.com wily-backports/multiverse amd64 Packages [28 B]
  取得:65 http://jp.archive.ubuntu.com wily-backports/main i386 Packages [619 B] 
  取得:66 http://jp.archive.ubuntu.com wily-backports/restricted i386 Packages [28 B]
  取得:67 http://jp.archive.ubuntu.com wily-backports/universe i386 Packages [1,998 B]
  取得:68 http://jp.archive.ubuntu.com wily-backports/multiverse i386 Packages [28 B]
  取得:69 http://jp.archive.ubuntu.com wily-backports/main Translation-en [496 B]
  取得:70 http://jp.archive.ubuntu.com wily-backports/multiverse Translation-en [28 B]
  取得:71 http://jp.archive.ubuntu.com wily-backports/restricted Translation-en [28 B]
  取得:72 http://jp.archive.ubuntu.com wily-backports/universe Translation-en [1,390 B]
34.1 MB を 32秒 で取得しました (1,058 kB/s)                                    
  パッケージリストを読み込んでいます... 完了
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ apt-get install git
E: ロックファイル /var/lib/dpkg/lock をオープンできません - open (13: Permission denied)
  E: 管理用ディレクトリ (/var/lib/dpkg/) をロックできません。root 権限で実行していますか?
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ sudo apt-get install git
  パッケージリストを読み込んでいます... 完了
  依存関係ツリーを作成しています                
  状態情報を読み取っています... 完了
  以下の追加パッケージがインストールされます:
  git-man liberror-perl
  提案パッケージ:
  git-daemon-run git-daemon-sysvinit git-doc git-el git-email git-gui gitk
  gitweb git-arch git-cvs git-mediawiki git-svn
  以下のパッケージが新たにインストールされます:
  git git-man liberror-perl
  アップグレード: 0 個、新規インストール: 3 個、削除: 0 個、保留: 245 個。
  3,634 kB のアーカイブを取得する必要があります。
  この操作後に追加で 24.6 MB のディスク容量が消費されます。
  続行しますか? [Y/n] Y
  取得:1 http://jp.archive.ubuntu.com/ubuntu/ wily/main liberror-perl all 0.17-1.1 [21.1 kB]
  取得:2 http://jp.archive.ubuntu.com/ubuntu/ wily-updates/main git-man all 1:2.5.0-1ubuntu0.2 [728 kB]
  取得:3 http://jp.archive.ubuntu.com/ubuntu/ wily-updates/main git amd64 1:2.5.0-1ubuntu0.2 [2,885 kB]
3,634 kB を 3秒 で取得しました (1,020 kB/s)
  以前に未選択のパッケージ liberror-perl を選択しています。
(データベースを読み込んでいます ... 現在 175834 個のファイルとディレクトリがインストールされています。)
  .../liberror-perl_0.17-1.1_all.deb を展開する準備をしています ...
  liberror-perl (0.17-1.1) を展開しています...
  以前に未選択のパッケージ git-man を選択しています。
  .../git-man_1%3a2.5.0-1ubuntu0.2_all.deb を展開する準備をしています ...
  git-man (1:2.5.0-1ubuntu0.2) を展開しています...
  以前に未選択のパッケージ git を選択しています。
  .../git_1%3a2.5.0-1ubuntu0.2_amd64.deb を展開する準備をしています ...
  git (1:2.5.0-1ubuntu0.2) を展開しています...
  man-db (2.7.4-1) のトリガを処理しています ...
  liberror-perl (0.17-1.1) を設定しています ...
  git-man (1:2.5.0-1ubuntu0.2) を設定しています ...
  git (1:2.5.0-1ubuntu0.2) を設定しています ...
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ git
  usage: git [--version] [--help] [-C <path>] [-c name=value]
  [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
  [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
  [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
  <command> [<args>]

  These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
  clone      Clone a repository into a new directory
  init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
  add        Add file contents to the index
  mv         Move or rename a file, a directory, or a symlink
  reset      Reset current HEAD to the specified state
  rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
  bisect     Find by binary search the change that introduced a bug
  grep       Print lines matching a pattern
  log        Show commit logs
  show       Show various types of objects
  status     Show the working tree status

  grow, mark and tweak your common history
  branch     List, create, or delete branches
  checkout   Switch branches or restore working tree files
  commit     Record changes to the repository
  diff       Show changes between commits, commit and working tree, etc
  merge      Join two or more development histories together
  rebase     Forward-port local commits to the updated upstream head
  tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
  fetch      Download objects and refs from another repository
  pull       Fetch from and integrate with another repository or a local branch
  push       Update remote refs along with associated objects

  'git help -a' and 'git help -g' list available subcommands and some
  concept guides. See 'git help <command>' or 'git help <concept>'
  to read about a specific subcommand or concept.
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ git config --global user.name "tsukudamayo"tsukudamayo@tsukudamayo-SVD1121AJ:~$ git config --global user.email "tsukudamayo@gmail.com"
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ git config --global core.quotepath false
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ git clone https://github.com/tsukudamayo/dotfiles.git
  Cloning into 'dotfiles'...
  remote: Counting objects: 71, done.
  remote: Total 71 (delta 0), reused 0 (delta 0), pack-reused 71
  Unpacking objects: 100% (71/71), done.
  Checking connectivity... done.
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ ln -sf ~/dotfiles/.vimrc ~/.vimrc
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ ln -sf ~/dotfiles/.bash_profile ~/.bash_profle
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ ln -sf ~/dotfiles/.bashrc ~/.bashrc
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ ln -sf ~/dotfiles/.vim ~/.vim
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ mv .gitconfig dotfiles
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ mv .gitconfig dotfiles_global dotfiles
  mv: cannot stat ‘.gitconfig’: No such file or directory
  mv: cannot stat ‘dotfiles_global’: No such file or directory
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ mv .gitconfig_global dotfilesmv: cannot stat ‘.gitconfig_global’: No such file or directory
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ cd dotfiles/
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ ls
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ ls -a
  .  ..  .bash_profile  .bashrc  .git  .gitconfig  .vim  .vimrc
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ git add .
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ git commit -m "add .gitconfig"

  *** Please tell me who you are.

  Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

  to set your account's default identity.
  Omit --global to set the identity only in this repository.

  fatal: unable to auto-detect email address (got 'tsukudamayo@tsukudamayo-SVD1121AJ.(none)')
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ cd ..
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ cd dotfiles/
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ vim .gitconfig 
  The program 'vim' can be found in the following packages:
  * vim
  * vim-gnome
  * vim-tiny
  * vim-athena
  * vim-gtk
  * vim-nox
  Try: sudo apt-get install <selected package>
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ vi .gitconfig 
  Error detected while processing /home/tsukudamayo/.vimrc:
  line    1:
  E319: Sorry, the command is not available in this version: syntax on
  line   18:
  E319: Sorry, the command is not available in this version: augroup fileTypeIndent
  line   19:
  E319: Sorry, the command is not available in this version:     autocmd!
  line   20:
  E319: Sorry, the command is not available in this version:     autocmd BufNewFile,BufRead *.py     setlocal tabstop=4 softtabstop=4 shiftwidth=4
  line   21:
  E319: Sorry, the command is not available in this version:     autocmd BufNewFile,BufRead *.rb     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  line   22:
  E319: Sorry, the command is not available in this version:     autocmd BufNewFile,BufRead *.html   setlocal tabstop=2 softtabstop=2 shiftwidth=2
  line   23:
  E319: Sorry, the command is not available in this version:     autocmd BufNewFile,BufRead *.md     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  line   24:
  E319: Sorry, the command is not available in this version:     autocmd BufNewFile,BufRead *.js     setlocal tabstop=2 softtabstop=2 shiftwidth=2
  line   25:
  E319: Sorry, the command is not available in this version:     autocmd BufNewFile,BufRead *.rst    setlocal tabstop=2 softtabstop=2 shiftwidth=2
  line   26:
  E319: Sorry, the command is not available in this version: augroup END
  Press ENTER or type command to continue
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ git add .
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ git commit -m "add .gitconfig"
  [master 363fddf] add .gitconfig
1 file changed, 5 insertions(+)
  create mode 100644 .gitconfig
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ git push -u origin master
  Username for 'https://github.com': tsukudamayo
  Password for 'https://tsukudamayo@github.com': 
  remote: Invalid username or password.
  fatal: Authentication failed for 'https://github.com/tsukudamayo/dotfiles.git/'
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ git push -u origin master
  Username for 'https://github.com': tsukudamayo
  Password for 'https://tsukudamayo@github.com': 
  Counting objects: 3, done.
  Delta compression using up to 4 threads.
  Compressing objects: 100% (3/3), done.
  Writing objects: 100% (3/3), 341 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
  To https://github.com/tsukudamayo/dotfiles.git
  631799f..363fddf  master -> master
  Branch master set up to track remote branch master from origin.
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ sudo apt-get install vim
  [sudo] password for tsukudamayo: 
  10Sorry, try again.
  [sudo] password for tsukudamayo: 
  パッケージリストを読み込んでいます... 完了
  依存関係ツリーを作成しています                
  状態情報を読み取っています... 完了
  以下の追加パッケージがインストールされます:
  vim-runtime
  提案パッケージ:
  ctags vim-doc vim-scripts
  以下のパッケージが新たにインストールされます:
  vim vim-runtime
  アップグレード: 0 個、新規インストール: 2 個、削除: 0 個、保留: 245 個。
  6,011 kB のアーカイブを取得する必要があります。
  この操作後に追加で 29.3 MB のディスク容量が消費されます。
  続行しますか? [Y/n] Y
  取得:1 http://jp.archive.ubuntu.com/ubuntu/ wily/main vim-runtime all 2:7.4.712-2ubuntu4 [4,984 kB]
  取得:2 http://jp.archive.ubuntu.com/ubuntu/ wily/main vim amd64 2:7.4.712-2ubuntu4 [1,028 kB]
6,011 kB を 42秒 で取得しました (142 kB/s)                                     
  以前に未選択のパッケージ vim-runtime を選択しています。
(データベースを読み込んでいます ... 現在 176620 個のファイルとディレクトリがインストールされています。)
  .../vim-runtime_2%3a7.4.712-2ubuntu4_all.deb を展開する準備をしています ...
  'vim-runtime による /usr/share/vim/vim74/doc/help.txt から /usr/share/vim/vim74/doc/help.txt.vim-tiny への退避 (divert)' を追加しています
  'vim-runtime による /usr/share/vim/vim74/doc/tags から /usr/share/vim/vim74/doc/tags.vim-tiny への退避 (divert)' を追加しています
  vim-runtime (2:7.4.712-2ubuntu4) を展開しています...
  以前に未選択のパッケージ vim を選択しています。
  .../vim_2%3a7.4.712-2ubuntu4_amd64.deb を展開する準備をしています ...
  vim (2:7.4.712-2ubuntu4) を展開しています...
  man-db (2.7.4-1) のトリガを処理しています ...
  vim-runtime (2:7.4.712-2ubuntu4) を設定しています ...
  Processing /usr/share/vim/addons/doc
  vim (2:7.4.712-2ubuntu4) を設定しています ...
  update-alternatives: /usr/bin/vim (vim) を提供するために自動モードで /usr/bin/vim.basic を使います
  update-alternatives: /usr/bin/vimdiff (vimdiff) を提供するために自動モードで /usr/bin/vim.basic を使います
  update-alternatives: /usr/bin/rvim (rvim) を提供するために自動モードで /usr/bin/vim.basic を使います
  update-alternatives: /usr/bin/rview (rview) を提供するために自動モードで /usr/bin/vim.basic を使います
  update-alternatives: /usr/bin/vi (vi) を提供するために自動モードで /usr/bin/vim.basic を使います
  update-alternatives: /usr/bin/view (view) を提供するために自動モードで /usr/bin/vim.basic を使います
  update-alternatives: /usr/bin/ex (ex) を提供するために自動モードで /usr/bin/vim.basic を使います
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ git clone https://github.com/yyuu/pyenv.git ~/.pyenv
  Cloning into '/home/tsukudamayo/.pyenv'...
  remote: Counting objects: 12744, done.
  remote: Total 12744 (delta 0), reused 0 (delta 0), pack-reused 12744
  Receiving objects: 100% (12744/12744), 2.26 MiB | 75.00 KiB/s, done.
  Resolving deltas: 100% (8837/8837), done.
  Checking connectivity... done.
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ $source ~/.bash_profile
  bash: /home/tsukudamayo/.bash_profile: No such file or directory
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ unlink ~/.bash_
  .bash_logout  .bash_profle  
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ unlink ~/.bash_profle 
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ source ~/.bash_profile 
  pyenv: no such command `virtualenv-init'
  The program 'rbenv' is currently not installed. You can install it by typing:
  sudo apt-get install rbenv
  No command 'plenv' found, did you mean:
  Command 'p7env' from package 'libnss3-tools' (main)
  plenv: command not found
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ pyenv install -l | grep ana
  anaconda-1.4.0
  anaconda-1.5.0
  anaconda-1.5.1
  anaconda-1.6.0
  anaconda-1.6.1
  anaconda-1.7.0
  anaconda-1.8.0
  anaconda-1.9.0
  anaconda-1.9.1
  anaconda-1.9.2
  anaconda-2.0.0
  anaconda-2.0.1
  anaconda-2.1.0
  anaconda-2.2.0
  anaconda-2.3.0
  anaconda-2.4.0
  anaconda-4.0.0
  anaconda2-2.4.0
  anaconda2-2.4.1
  anaconda2-2.5.0
  anaconda2-4.0.0
  anaconda3-2.0.0
  anaconda3-2.0.1
  anaconda3-2.1.0
  anaconda3-2.2.0
  anaconda3-2.3.0
  anaconda3-2.4.0
  anaconda3-2.4.1
  anaconda3-2.5.0
  anaconda3-4.0.0
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ pyenv install anaconda3-4.0.0
  Downloading Anaconda3-4.0.0-Linux-x86_64.sh...
  -> https://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh


  ^Ctsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ vim .bash_profile 
  /home/tsukudamayo/.vimrc の処理中にエラーが検出されました:
  行   56:
  E117: 未知の関数です: neobundle#begin
  行   58:
  E492: エディタのコマンドではありません: NeoBundleFetch 'Shougo/neobundle.vim'
  行   60:
  E492: エディタのコマンドではありません: NeoBundle 'plasticboy/vim-markdown'
  行   61:
  E492: エディタのコマンドではありません: NeoBundle 'kannokanno/previm'
  行   62:
  E492: エディタのコマンドではありません: NeoBundle 'tyru/open-browser.vim'
  行   64:
  E117: 未知の関数です: neobundle#end
  行   68:
  E492: エディタのコマンドではありません: NeoBundleCheck
  続けるにはENTERを押すかコマンドを入力してください
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ vim .bash_rc
  /home/tsukudamayo/.vimrc の処理中にエラーが検出されました:
  行   56:
  E117: 未知の関数です: neobundle#begin
  行   58:
  E492: エディタのコマンドではありません: NeoBundleFetch 'Shougo/neobundle.vim'
  行   60:
  E492: エディタのコマンドではありません: NeoBundle 'plasticboy/vim-markdown'
  行   61:
  E492: エディタのコマンドではありません: NeoBundle 'kannokanno/previm'
  行   62:
  E492: エディタのコマンドではありません: NeoBundle 'tyru/open-browser.vim'
  行   64:
  E117: 未知の関数です: neobundle#end
  行   68:
  E492: エディタのコマンドではありません: NeoBundleCheck
  続けるにはENTERを押すかコマンドを入力してください
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ vim .bash
  /home/tsukudamayo/.vimrc の処理中にエラーが検出されました:
  行   56:
  E117: 未知の関数です: neobundle#begin
  行   58:
  E492: エディタのコマンドではありません: NeoBundleFetch 'Shougo/neobundle.vim'
  行   60:
  E492: エディタのコマンドではありません: NeoBundle 'plasticboy/vim-markdown'
  行   61:
  E492: エディタのコマンドではありません: NeoBundle 'kannokanno/previm'
  行   62:
  E492: エディタのコマンドではありません: NeoBundle 'tyru/open-browser.vim'
  行   64:
  E117: 未知の関数です: neobundle#end
  行   68:
  E492: エディタのコマンドではありません: NeoBundleCheck
  続けるにはENTERを押すかコマンドを入力してください
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ vim .bashrc 
  /home/tsukudamayo/.vimrc の処理中にエラーが検出されました:
  行   56:
  E117: 未知の関数です: neobundle#begin
  行   58:
  E492: エディタのコマンドではありません: NeoBundleFetch 'Shougo/neobundle.vim'
  行   60:
  E492: エディタのコマンドではありません: NeoBundle 'plasticboy/vim-markdown'
  行   61:
  E492: エディタのコマンドではありません: NeoBundle 'kannokanno/previm'
  行   62:
  E492: エディタのコマンドではありません: NeoBundle 'tyru/open-browser.vim'
  行   64:
  E117: 未知の関数です: neobundle#end
  行   68:
  E492: エディタのコマンドではありません: NeoBundleCheck
  続けるにはENTERを押すかコマンドを入力してください
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ vim .bash_profile 
  /home/tsukudamayo/.vimrc の処理中にエラーが検出されました:
  行   56:
  E117: 未知の関数です: neobundle#begin
  行   58:
  E492: エディタのコマンドではありません: NeoBundleFetch 'Shougo/neobundle.vim'
  行   60:
  E492: エディタのコマンドではありません: NeoBundle 'plasticboy/vim-markdown'
  行   61:
  E492: エディタのコマンドではありません: NeoBundle 'kannokanno/previm'
  行   62:
  E492: エディタのコマンドではありません: NeoBundle 'tyru/open-browser.vim'
  行   64:
  E117: 未知の関数です: neobundle#end
  行   68:
  E492: エディタのコマンドではありません: NeoBundleCheck
  続けるにはENTERを押すかコマンドを入力してください
  tsukudamayo@tsukudamayo-SVD1121AJ:~/dotfiles$ cd ..
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ pyenv
  pyenv 20160509-25-g4c654d7
  Usage: pyenv <command> [<args>]

  Some useful pyenv commands are:
  commands    List all available pyenv commands
  local       Set or show the local application-specific Python version
  global      Set or show the global Python version
  shell       Set or show the shell-specific Python version
  install     Install a Python version using python-build
  uninstall   Uninstall a specific Python version
rehash      Rehash pyenv shims (run this after installing executables)
  version     Show the current Python version and its origin
  versions    List all Python versions available to pyenv
  which       Display the full path to an executable
  whence      List all Python versions that contain the given executable

  See `pyenv help <command>' for information on a specific command.
  For full documentation, see: https://github.com/yyuu/pyenv#readme
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ pyenv install -l ana
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ pyenv install anaconda3-4.0.0
  Downloading Anaconda3-4.0.0-Linux-x86_64.sh...
  -> https://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh
  ^Ctsukudamayo@tsukudamayo-SVD1121AJ:~$ source ~/.bash_profile 
  The program 'rbenv' is currently not installed. You can install it by typing:
  sudo apt-get install rbenv
  No command 'plenv' found, did you mean:
  Command 'p7env' from package 'libnss3-tools' (main)
  plenv: command not found
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ vim ~/.bash_profile 
  /home/tsukudamayo/.vimrc の処理中にエラーが検出されました:
  行   56:
  E117: 未知の関数です: neobundle#begin
  行   58:
  E492: エディタのコマンドではありません: NeoBundleFetch 'Shougo/neobundle.vim'
  行   60:
  E492: エディタのコマンドではありません: NeoBundle 'plasticboy/vim-markdown'
  行   61:
  E492: エディタのコマンドではありません: NeoBundle 'kannokanno/previm'
  行   62:
  E492: エディタのコマンドではありません: NeoBundle 'tyru/open-browser.vim'
  行   64:
  E117: 未知の関数です: neobundle#end
  行   68:
  E492: エディタのコマンドではありません: NeoBundleCheck
  続けるにはENTERを押すかコマンドを入力してください
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ source ~/.bash_profile 
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ pyenv install anaconda3-4.0.0
  Downloading Anaconda3-4.0.0-Linux-x86_64.sh...
  -> https://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh
  ^Ctsukudamayo@tsukudamayo-SVD1121AJ:~$ pyenv install -l | grep mini
  miniconda-latest
  miniconda-2.2.2
  miniconda-3.0.0
  miniconda-3.0.4
  miniconda-3.0.5
  miniconda-3.3.0
  miniconda-3.4.2
  miniconda-3.7.0
  miniconda-3.8.3
  miniconda-3.9.1
  miniconda-3.10.1
  miniconda-3.16.0
  miniconda-3.18.3
  miniconda2-latest
  miniconda2-3.18.3
  miniconda2-3.19.0
  miniconda2-4.0.5
  miniconda3-latest
  miniconda3-2.2.2
  miniconda3-3.0.0
  miniconda3-3.0.4
  miniconda3-3.0.5
  miniconda3-3.3.0
  miniconda3-3.4.2
  miniconda3-3.7.0
  miniconda3-3.8.3
  miniconda3-3.9.1
  miniconda3-3.10.1
  miniconda3-3.16.0
  miniconda3-3.18.3
  miniconda3-3.19.0
  miniconda3-4.0.5
  tsukudamayo@tsukudamayo-SVD1121AJ:~$ pyenv install miniconda3-4.0.5
  Downloading Miniconda3-4.0.5-Linux-x86_64.sh...
  -> https://repo.continuum.io/miniconda/Miniconda3-4.0.5-Linux-x86_64.sh
  
