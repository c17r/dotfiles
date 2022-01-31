is_osx || return 1

export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_ANALYTICS=1

function brew() {
	/usr/bin/env PATH="$(path_remove $(pyenv root)/shims)" /usr/local/bin/brew "$@"
}
