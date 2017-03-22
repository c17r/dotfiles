# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P /usr/local/bin/brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask keg and recipe are installed.
kegs=(caskroom/cask)
brew_tap_kegs
recipes=(brew-cask)
brew_install_recipes

# Exit if, for some reason, cask is not installed.
[[ ! "$(brew ls --versions brew-cask)" ]] && e_error "Brew-cask failed to install." && return 1

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Homebrew casks
casks_common=(
  amazon-music
  box-sync
  caffeine
  disk-inventory-x
  divvy
  dropbox
  fluid
  flux
  goofy
  google-chrome
  gyazo
  java
  logmein-hamachi
  macdown
  microsoft-office
  royal-tsx
  skype
  slack
  sublime-text
  suspicious-package
  the-unarchiver
  twitterrific
  vlc
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
)

casks_work=(
  diffmerge
  filezilla
  gimp
  gitup
  hex-fiend
  kdiff3
  launchrocket
  mysqlworkbench
  parallels-desktop
  pgadmin3
  postman
  vagrant
  virtualbox
  xquartz #for wireshark
  wireshark
)

casks_play=(
  audacity
  filebot
  fitbit-connect
  google-earth
  handbrake
  minecraft
  phoneview
  steam
  teamspeak-client
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
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cask cleanup
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
