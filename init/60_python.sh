source $DOTFILES/source/50_python.sh

py2=$(pyenv install --list | grep -ve "[a-zA-Z]" | grep -E "\s+2.\d+\." | tail -1)
py3=$(pyenv install --list | grep -ve "[a-zA-Z]" | grep -E "\s+3.\d+\." | tail -1)

echo py2 is $py2
echo py3 is $py3

(pyenv versions | grep $py3 > /dev/null 2>&1) || pyenv install $py3
(pyenv versions | grep $py2 > /dev/null 2>&1) || pyenv install $py2

pyenv rehash
pyenv global $py3 $py2

pipcmd=$(pyenv which pip)

$pipcmd install --upgrade pip setuptools wheel
$pipcmd install --upgrade virtualenvwrapper

pips=(
	arrow
	requests
	grequests
	notebook
	streamlink
	pipenv
	beautifulsoup4
	lxml
	gspread
	oauth2client
	em-keyboard
	praw
	youtube-dl
	Pillow
)

for pip in "${pips[@]}"; do
	pip install --upgrade $pip
done

if [[ ! -f ~/.pypirc ]]; then
	ln -nsf ~/odrive/Box/Sync/secrets/.pypirc
fi
