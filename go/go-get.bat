mkdir %GOPATH%\bin
mkdir %GOPATH%\pkg
mkdir %GOPATH%\src


go get github.com\motemen\ghq
git config --global ghq.root %GOPATH%\src

go get -u github.com\motemen\gore
go get -u github.\nsf\gocode
go get -u github.com\k0kubun\pp
go get -u golang.org\x\tools\cmd\godoc
go get -u github.com\golang\lint\golint
go get -u golang.org\x\tools\cmd\gorename
go get -u golang.org\x\tools\cmd\guru
go get -u github.com\nsf\gocode
go get -u github.com\rogpeppe\godef
go get -u github.com\jstemmer\gotags
go get -u github.com\kisielk\errcheck
go get -u github.com\julienschmidt\httprouter
go get -u golang.org\x\net\http2

go get -u github.com\tsenart\vegeta
go get -u github.com\derekparker\delve\cmd\dlv 

go get -u github.com\gorilla\mux
go get -u github.com\gorilla\handlers
go get -u github.com\gorilla\schema
go get -u github.com\gorilla\sessions

go get -u gopkg.in\boj\redistore.v1
go get -u github.com\labstack\echo
