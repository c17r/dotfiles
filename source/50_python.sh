
if which pyenv > /dev/null; then 
	eval "$(pyenv init -)"
fi

# Recursively run all python files through pep8
alias allpep8='find . -name "*.py" -print0 | xargs -0 pep8'

# Recusively delete all pre-compiled python files
alias pyclean='find . \( -name "*.pyc" -or -name "*.pyo" -or -name "*py.class" \) -delete'
