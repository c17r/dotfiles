# Initialize rbenv.
source $DOTFILES/source/50_ruby.sh

rb2=$(rbenv install --list | grep -ve "[a-zA-Z]" | grep -E "\s+2\.\d+\." | tail -1)

echo rb2 is $rb2

(rbenv versions | grep $rb2 > /dev/null 2>&1) || pyenv install $rb2

rbenv rehash
rbenv global $rb2
