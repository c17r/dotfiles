is_osx || return 1

export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

export HOMEBREW_BIN=/opt/homebrew/bin
export PATH="$HOMEBREW_BIN:$(path_remove $HOMEBREW_BIN)"

function brew() {
	/usr/bin/env PATH="$(path_remove $(pyenv root)/shims)" /opt/homebrew/bin/brew "$@"
}

function brew-update() {
	brew update && brew upgrade && brew pyenv-sync && brew rbenv-sync && brew nodenv-sync
}