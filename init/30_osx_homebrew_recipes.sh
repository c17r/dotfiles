# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P $BREW_BIN)" ]] && e_error "Brew recipes need Homebrew to install." && return 1

# Homebrew recipes
recipes_common=(
  bash
  composer
  coreutils
  direnv
  editorconfig
  findutils
  font-jetbrains-mono
  gist
  git
  git-cola
  hub
  java
  mas
  nave
  poetry
  pyenv
  pyenv-virtualenvwrapper
  rbenv
  ripgrep
  ruby-build
  tree
  wakeonlan
  wget
  z
)

recipes_work=(
  asciidoc
  caddy
  dnsmasq
  entr
  gh
  gnupg
  httpie
  jq
  nmap
  tmux
)

recipes_play=(
  handbrake
)

recipes=(
  ${recipes_common[@]}
)

read -p "Include work? " include_work
case $include_work in
  y*|Y*)
    recipes=(
      ${recipes[@]}
      ${recipes_work[@]}
    )
  ;;
esac

read -p "Include play? " include_play
case $include_play in
  y*|Y*)
    recipes=(
      ${recipes[@]}
      ${recipes_play[@]}
    )
  ;;
esac

brew_install_recipes

# Misc cleanup!

# This is where brew stores its binary symlinks
local binroot="$($BREW_BIN --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# htop
if [[ "$(type -P $binroot/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$binroot/htop")" != "root:wheel" || ! "$(($(stat -L -f "%DMp" "$binroot/htop") & 4))" ]]; then
  e_header "Updating htop permissions"
  sudo chown root:wheel "$binroot/htop"
  sudo chmod u+s "$binroot/htop"
fi

# bash
if [[ "$(type -P $binroot/bash)" && "$(cat /etc/shells | grep -q "$binroot/bash")" ]]; then
  e_header "Adding $binroot/bash to the list of acceptable shells"
  echo "$binroot/bash" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$binroot/bash" ]]; then
  e_header "Making $binroot/bash your default shell"
  sudo chsh -s "$binroot/bash" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi
