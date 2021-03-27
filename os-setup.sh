#!/bin/bash

echo "Starting Setup"

echo "Installing Terminal Stuff..."
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Symlink dotfiles..."
ln -nfsv ~/dotfiles/config/.aliases ~/.aliases
ln -nfsv ~/dotfiles/config/.p10k.sh ~/.p10k.sh
ln -nfsv ~/dotfiles/config/.zshrc ~/.zshrc

if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

PACKAGES=(
    dockutil
    git
    lsd
    neofetch
    python
    thefuck
    tmux
    zsh
)

echo "Installing homebrew packages..."
brew install ${PACKAGES[@]}

echo "Installing cask..."
CASKS=(
    adobe-acrobat-reader
    calibre
    discord
    iterm2
    firefox
    font-hack-nerd-font
    font-source-code-pro
    lastpass
    manictime
    mendeley
    microsoft-teams
    signal
    spotify
    taskwarrior-pomodoro
    texmaker
    visual-studio-code
    zoom
)

echo "Installing cask apps..."
brew tap homebrew/cask-fonts
brew install --cask ${CASKS[@]}


echo "Installing VS Code extensions..."
VS_EXTS=(
	CoenraadS.bracket-pair-colorizer-2
	esbenp.prettier-vscode
	jeff-hykin.better-cpp-syntax
	ms-python.python
	ms-toolsai.jupyter
	ms-vscode.cpptools
	redhat.java
	SonarSource.sonarlint-vscode
	VisualStudioExptTeam.vscodeintellicode
	vscjava.vscode-java-debug
	vscjava.vscode-java-dependency
	vscjava.vscode-java-pack
	vscjava.vscode-java-test
	vscjava.vscode-maven
	WakaTime.vscode-wakatime
)

code --install-extension ${VS_EXTS[@]}

echo "Setting OS defaults..."
bash macOS/defaults.sh

echo "Updating dock..."
bash macOS/dock.sh

# powerlevel10k theme
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# iTerm2 preferences
cp ~/dotfiles/config/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences

# zsh-plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search


echo "Startup complete!"
