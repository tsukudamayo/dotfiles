mkdir %GOPATH%\bin
mkdir %GOPATH%\pkg
mkdir %GOPATH%\src


go get github.com\motemen\ghq
git config --global ghq.root %GOPATH%\src

go get github.com\motemen\gore
go get github.\nsf\gocode
go get github.com\k0kubun\pp
go get golang.org\x\tools\cmd\godoc
go get github.com\golang\lint\golint
go get golang.org\x\tools\cmd\gorename
go get golang.org\x\tools\cmd\guru
go get github.com\nsf\gocode
go get github.com\rogpeppe\godef
go get github.com\jstemmer\gotags
go get github.com\kisielk\errcheck
go get github.com/julienschmidt/httprouter
go get golang.org/x/net/http2

go get -u github.com\tsenart\vegeta
go get github.com\derekparker\delve\cmd\dlv 
