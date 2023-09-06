source $DOTFILES/source/60_go.sh

go1=$(goenv install --list | grep -ve "[a-zA-Z]" | grep -E "^\s*1\.\d+\." | tail -1)

echo go1 is $go1

(goenv versions | grep $go1 > /dev/null 2>&1) || goenv install $go1

goenv rehash
goenv global $go1