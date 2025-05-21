# OSX-only stuff. Abort if not OSX.
is_osx || return 1

defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

defaults write com.apple.dashboard mcx-disabled -bool true

defaults write com.apple.dock orientation -string right
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

defaults write com.apple.screencapture disable-shadow -bool false
defaults write com.apple.screencapture include-date -bool true
defaults write com.apple.screencapture location -string ~/Desktop
defaults write com.apple.screencapture show-thumbnail -bool false
defaults write com.apple.screencapture type -string png

defaults write com.apple.finder QuitMenuItem -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.Finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
defaults write com.apple.finder ShowStatusBar -bool true # show Finder status bar by default

defaults write com.apple.menuextra.clock FlashDateSeparators -bool false && killall SystemUIServer
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss"

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

defaults write com.apple.helpviewer DevMode -bool false

defaults write com.apple.Music userWantsPlaybackNotifications -bool false

defaults write com.apple.LaunchServices LSQuarantine -bool false

defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6
