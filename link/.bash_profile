if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.bash 2>/dev/null || :
