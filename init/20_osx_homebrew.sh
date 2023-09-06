# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Install Homebrew.
if [[ ! "$(type -P /opt/homebrew/bin/brew)" ]]; then
  e_header "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

BREW_PATH=/opt/homebrew
export BREW_BIN=$BREW_PATH/bin/brew

eval $($BREW_BIN shellenv)

# Exit if, for some reason, Homebrew is not installed.
[[ ! "$(type -P $BREW_BIN)" ]] && e_error "Homebrew failed to install." && return 1

e_header "Updating Homebrew"
$BREW_BIN doctor
$BREW_BIN update
# Functions used in subsequent init scripts.

# Tap Homebrew kegs.
function brew_tap_kegs() {
  kegs=($(setdiff "${kegs[*]}" "$(brew tap)"))
  if (( ${#kegs[@]} > 0 )); then
    e_header "Tapping Homebrew kegs: ${kegs[*]}"
    for keg in "${kegs[@]}"; do
      $BREW_BIN tap $keg
    done
  fi
}

# Install Homebrew recipes.
function brew_install_recipes() {
  recipes=($(setdiff "${recipes[*]}" "$(brew list)"))
  if (( ${#recipes[@]} > 0 )); then
    e_header "Installing Homebrew recipes: ${recipes[*]}"
    for recipe in "${recipes[@]}"; do
      $BREW_BIN install $recipe
    done
  fi
}
