
[[ -e /usr/local/bin/virtualenvwrapper.sh ]] || return 1

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=$WORKON_HOME