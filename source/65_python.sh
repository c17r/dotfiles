
if which pyenv > /dev/null; then
	export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$(path_remove $PYENV_ROOT/bin)"
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
	pyenv virtualenvwrapper
fi

if [ -f /usr/local/opt/autoenv/activate.sh ]; then
	export AUTOENV_ENV_FILENAME=".pyenv"
	source /usr/local/opt/autoenv/activate.sh
fi

export PATH="$HOME/.poetry/bin:$(path_remove $HOME/.poetry/bin)"

# Recursively run all python files through pep8
alias allpep8='find . -name "*.py" -print0 | xargs -0 pep8'

# Recusively delete all pre-compiled python files
alias pyclean='find -E . \( \( -type f -regex ".*\.py(c|o|\.class)$" \) -or \( -type d -name "__pycache__" \) \) -delete'

export PIPENV_DEFAULT_PYTHON_VERSION=3.13
export PYTHONDONTWRITEBYTECODE=1

function pyenv_install() {
	[[ ! "$1" ]] && echo "Specify a python version" && return 1
	CFLAGS="-I$(xcrun --show-sdk-path)/usr/include -I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(brew --prefix zlib)/include -I$(brew --prefix sqlite)/include" LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix bzip2)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix sqlite)/lib" pyenv install -f $1
}

function pyenv_latest_py2() {
	_pyenv_search "\s2\.7"
}

function pyenv_latest_py3() {
	_pyenv_search "\s3\.5"
	_pyenv_search "\s3\.6"
	_pyenv_search "\s3\.7"
	_pyenv_search "\s3\.8"
	_pyenv_search "\s3\.9"
	_pyenv_search "\s3\.10"
	_pyenv_search "\s3\.11"
	_pyenv_search "\s3\.12"
	_pyenv_search "\s3\.13"
	_pyenv_search "\s3\.14"
	_pyenv_search "\s3\.15"
	_pyenv_search "\s3\.16"
	_pyenv_search "\s3\.17"
}

function _pyenv_search() {
	pyenv install --list | grep -ve "[a-zA-Z]" | egrep "$1" | tail -1
}
