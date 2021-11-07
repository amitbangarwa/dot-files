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


echo "Installing cask apps..."
declare -a cask_apps=(
    'alfred'
    'google-chrome'
    'firefox'
    'slack'
    'skype'
    'jetbrains-toolbox'
    'visual-studio-code'
    'sublime-text'
    'iterm2'
    'insomnia'  # alternative - postman
    '1password'
    'docker'
    'stats'
    'vlc'
    'transmission'
    'dropbox'
    'discord'
    'notion'
)

for app in "${cask_apps[@]}"; do
  brew cask install "$app"
done

echo "Installing packages..."
declare -a packages=(
  'awscli'
  'cowsay' # i mean, why not?
  'ytop'
  'ctop'
  'htop'
  'hub'
  'parallel'
  'bat'
  'exa'
  'fd'
  'wifi-password'
  'zsh'
  'zsh-syntax-highlighting'
  'zsh-autosuggestions'
  'hstr'
  'mas'
  'tldr'
  'git'
  'fd'
  'dust'
  'grex'
  'go'
  'gradle'
  'ripgrep'
  'thfuck'
  'httpie'
  'hugo'
  'redis'
  'postgres'
  'screenfetch'
  'node'
  'npm'
  'zlib'
  'nmap'
)

for package in "${packages[@]}"; do
  brew install "$package"
done

###############################################################################
# Configure installed apps                                                    #
###############################################################################

echo "Configuring and cleaning the shell prompt ✨"

# Set ZSH as the default shell
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Add nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Set powerlevel10k as the default theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Add zsh plugins

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Remove outdated versions from the cellar.
brew cleanup

###############################################################################
# General UI/UX                                                               #
###############################################################################

echo "Making some adjustments to global setting for this MAC"

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"


###############################################################################
# 📱 Dock
###############################################################################

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.05
defaults write com.apple.dock autohide-time-modifier -float 0.25
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock tilesize -int 54
defaults write com.apple.dock largesize -int 64
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock show-process-indicators -bool true


###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Install the Solarized Dark theme for iTerm
open "${HOME}/init/Solarized Dark.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
