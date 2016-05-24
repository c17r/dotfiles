py2=$(pyenv install --list | grep -E "\s+2.\d+\." | tail -1)
py3=$(pyenv install --list | grep -E "\s+3.\d+\." | tail -1)

pyenv install $py2 $py3
pyenv rehash
pyenv global $py3 $py2

pip install --upgrade pip

pip install virtualenvwrapper
