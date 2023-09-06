
if which goenv > /dev/null; then
	export GOENV_ROOT="$HOME/.goenv"
	export PATH="$GOENV_ROOT/bin:$(path_remove $GOENV_ROOT/bin)"
	eval "$(goenv init -)"
	export PATH="$GOROOT/bin:$(path_remove $GOROOT/bin)"
	export PATH="$(path_remove $GOPATH/bin):$GOPATH/bin"
fi