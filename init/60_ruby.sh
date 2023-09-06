# Initialize rbenv.
source $DOTFILES/source/60_ruby.sh

rb2=$(rbenv install --list-all | grep -ve "[a-zA-Z]" | grep -E "^2\.\d+\." | tail -1)
rb3=$(rbenv install --list-all | grep -ve "[a-zA-Z]" | grep -E "^3\.\d+\." | tail -1)

echo rb2 is $rb2
echo rb3 is $rb3

(rbenv versions | grep $rb2 > /dev/null 2>&1) || rbenv install $rb2
(rbenv versions | grep $rb3 > /dev/null 2>&1) || rbenv install $rb3

rbenv rehash
rbenv global $rb3 $rb2
