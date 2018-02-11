export GOPATH=$HOME/wc/go

if [[ -b $GOPATH ]]; then
	export PATH=$PATH:$GOPATH/bin
fi
