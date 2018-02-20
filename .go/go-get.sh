mkdir $GOPATH/bin
mkdir $GOPATH/pkg
mkdir $GOPATH/src


go get github.com/motemen/ghq
git config --global ghq.root $GOPATH/src

go get github.com/motemen/gore
go get github./nsf/gocode
go get github.com/k0kubun/pp
go get golang.org/x/tools/cmd/godoc
go get github.com/golang/lint/golint
go get golang.org/x/tools/cmd/gorename
go get golang.org/x/tools/cmd/guru
go get github.com/nsf/gocode
go get github.com/rogpeppe/godef
go get github.com/jstemmer/gotags
go get github.com/kisielk/errcheck

cd ~/lib/go/pkg
tar zxvf ~/etc/peco_linux_amd64.tar.gz
mv peco_linux_amd64/peco ../bin/

go get -u github.com/tsenart/vegeta
go get github.com/derekparker/delve/cmd/dlv 
