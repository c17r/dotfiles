is_osx || return 1

export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

export HOMEBREW_BIN=/opt/homebrew/bin
export PATH="$HOMEBREW_BIN:$(path_remove $HOMEBREW_BIN)"

export HOMEBREW_SBIN=/opt/homebrew/sbin
export PATH="$HOMEBREW_SBIN:$(path_remove $HOMEBREW_SBIN)"

export HOMEBREW_CPATH="/opt/homebrew/include"
export CPATH="$HOMEBREW_CPATH:$(path_remove $HOMEBREW_CPATH)"

export HOMEBREW_LIBRARY_PATH="/opt/homebrew/lib"
export LIBRARY_PATH="$HOMEBREW_LIBRARY_PATH:$(path_remove $HOMEBREW_LIBRARY_PATH)"

function brew() {
	/usr/bin/env PATH="$(path_remove $(pyenv root)/shims)" /opt/homebrew/bin/brew "$@"
}

function brew-update() {
	brew update && brew upgrade && brew pyenv-sync && brew rbenv-sync && brew nodenv-sync
}
