# OSX-only stuff. Abort if not OSX.
is_osx || return 1

defaults write com.apple.mail UserHeaders '{"X-Clacks-Overhead" = "GNU Terry Pratchett";}'
