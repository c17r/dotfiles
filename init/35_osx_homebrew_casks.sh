# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(
  homebrew/cask-drivers
  homebrew/cask-fonts
  homebrew/cask-versions
  sdkman/tap
)
brew_tap_kegs

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Homebrew casks
casks_common=(
  amazon-music
  appcleaner
  caffeine
  carbon-copy-cloner
  disk-inventory-x
  divvy
  flameshot
  fluid
  flux
  google-chrome
  gyazo
  macdown
  microsoft-office
  odrive
  # phoneview # install manually now
  rectangle
  royal-tsx
  sublime-merge
  sublime-text
  suspicious-package
  tailscale
  the-unarchiver
  twitterrific
  visual-studio-code
  vlc
  zoom
  ghostty

  # Quick Look plugins
  betterzipql
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-csv
  quicklook-json
  quicknfo
  webpquicklook

  # Color pickers
  colorpicker-developer
  colorpicker-skalacolor

  dotnet-sdk
  sdkman-cli
)

casks_work=(
  datagrip
  diffmerge
  docker
  gimp
  hex-fiend
  launchrocket
  postman
  pycharm
  rider
  virtualbox
  webstorm
  wireshark
  xquartz #for wireshark
)

casks_play=(
  audacity
  handbrake
  messenger
  minecraft
  steam
)

casks=(
  ${casks_common[@]}
)

read -p "Include work? " include_work
case $include_work in
  y*|Y*)
    casks=(
      ${casks[@]}
      ${casks_work[@]}
    )
  ;;
esac

read -p "Include play? " include_play
case $include_play in
  y*|Y*)
    casks=(
      ${casks[@]}
      ${casks_play[@]}
    )
  ;;
esac

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$($BREW_BIN list --cask 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    $BREW_BIN install --cask $cask
  done
  $BREW_BIN cleanup
fi

# Work around colorPicker symlink issue.
# https://github.com/caskroom/homebrew-cask/issues/7004
cps=()
for f in ~/Library/ColorPickers/*.colorPicker; do
  [[ -L "$f" ]] && cps=("${cps[@]}" "$f")
done

if (( ${#cps[@]} > 0 )); then
  e_header "Fixing colorPicker symlinks"
  for f in "${cps[@]}"; do
    target="$(readlink "$f")"
    e_arrow "$(basename "$f")"
    rm "$f"
    cp -R "$target" ~/Library/ColorPickers/
  done
fi
