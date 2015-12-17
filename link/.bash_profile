if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
