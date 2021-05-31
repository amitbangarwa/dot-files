#!/usr/bin/env bash


# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Hey $(whoami)! Let's get your Macbook setup"

##################################################
# Setup directoryies for proejcts and screenshots 
##################################################

echo "Creating code directory"
mkdir -p "${HOME}/code"
echo "Dev directory successfully created ✅"

echo "Creating screenshots directory on desktop"
mkdir -p "${HOME}/Desktop/Screenshots"
echo "Screenshots directory successfully created ✅"

##################################################
# Install brew and brew cask apps
##################################################

# Check for Homebrew, install if we don't have it

if test ! $(which brew); then
    echo "Installing homebrew 🍺"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
echo "Homebrew installed"


echo "Brewing some apps 🍻"
brew tap homebrew/cask-versions
brew tap homebrew/cask-fonts
brew tap caskroom/cask

declare -a cask_apps=(
    'alfred'
  'google-chrome'
  'firefox'
  'slack'
  'skype'
  'jetbrains-toolbox'
  'visual-studio-code'
  'sublime-text'
  'insomnia'
  '1password'
  'rocket'
  'caffeine'
  'slack'
  'docker'
  'postman'
  'iterm2'
  'fork'
  'stats'
  'jetbrains-toolbox'
  'visual-studio-code'
  'sublime-text'
  'vlc'
  'transmission'
  'appcleaner'
  'colorpicker-skalacolor'
  'dropbox'
)

for app in "${brew_cask_apps[@]}"; do
  brew cask install "$app"
done

