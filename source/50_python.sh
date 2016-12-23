
if which pyenv > /dev/null; then 
	eval "$(pyenv init -)"
	pyenv virtualenvwrapper
	export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
fi

if [ -f /usr/local/opt/autoenv/activate.sh ]; then
	source /usr/local/opt/autoenv/activate.sh
fi

# Recursively run all python files through pep8
alias allpep8='find . -name "*.py" -print0 | xargs -0 pep8'

# Recusively delete all pre-compiled python files
alias pyclean='find -E . \( \( -type f -regex ".*\.py(c|o|\.class)$" \) -or \( -type d -name "__pycache__" \) \) -delete'
