mkdir $GOPATH/bin
mkdir $GOPATH/pkg
mkdir $GOPATH/src


go get github.com/motemen/ghq
git config --global ghq.root $GOPATH/src

go get github.com/motemen/gore
go get github.com/nsf/gocode
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

go get github.com/PuerkitoBio/goquery 
go get -u github.com/gorilla/mux
go get -u github.com/gorilla/handlers
go get -u github.com/gorilla/schema
go get -u github.com/gorilla/sessions

go get -u gopkg.in/boj/redistore.v1
go get -u github.com/labstack/echo
go get -u github.com/labstack/echo/middleware

go get -u google.golang.org/grpc
go get -u golang.org/x/sys/unix
go get -u github.com/golang/protobuf/protoc-gen-go
go get -u google.golang.org/grpc

go get -u github.com/go-sql-driver/mysql
go get -u github.com/lib/pq
go get -u github.com/jinzhu/gorm
