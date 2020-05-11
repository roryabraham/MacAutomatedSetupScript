#!/usr/bin/env bash

# import shared functions
source ./shared-functions.sh
if ["$?" != "0"]
then echo "Error importing shared functions.\n" && exit 1
fi

# Write command aliases to ~/.bash_profile and ~/.zshrc
# (many assume vscode `code` command-line-invocation is setup)
begin_configuration "shell aliases"
write_to_shell_config 'alias zshconfig="code ~/.zshrc"'
write_to_shell_config 'alias bashconfig="code ~/.bash_profile"'
write_to_shell_config 'alias gitconfig="code ~/.gitconfig"'
write_to_shell_config 'alias ohmyzsh="code ~/.oh-my-zsh"'
# just use python3 by default
write_to_shell_config 'alias python="python3"'

# Bash-specific terminal customizations
begin_configuration "bash-specific terminal customizations"
echo $(cat ./.bash_profile_content) >> ~/.bash_profile

# Download and install iTerm2
begin_install "iTerm2"
brew cask install iterm2
report_install_success 'iTerm2'

# Install latest version of zsh
"\n\nInstalling latest version of zsh...\n"
begin_install "latest version of zsh"
HOMEBREW_NO_AUTO_UPDATE=1 brew install zsh
zsh --version
report_install_success 'zsh'

# Set zsh as system default
chsh -s $(which zsh)
if [$(echo $SHELL) != "/bin/zsh"]
then echo "WARNING: zsh may not be the system default shell. (try running 'echo \$SHELL' after terminal restart)\n"
fi

# Install oh-my-zsh
begin_install "oh-my-zsh"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
report_install_success "oh-my-zsh"

# Download and configure custom oh-my-zsh plugins
echo "\n\nSetting up oh-my-zsh plugins...\n"
echo "\nCloning zsh-nvm plugin...\n"
git clone https://github.com/lukechilds/zsh-nvm \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
echo "\nCloning zsh-syntax-highlighting...\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "\nCloning zsh-autosuggestions...\n"
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Find and replace plugins line in ~/.zshrc
begin_configuration "oh-my-zsh plugins"
ZSH_PLUGINS="plugins(git brew docker npm zsh-nvm zsh-syntax-highlighting zsh-autosuggestions)\n"
if grep -q "plugins(.*)" ~/.zshrc
then sed -i "s/plugins(.*)/${ZSH_PLUGINS}/g" ~/.zshrc
else echo "\n${ZSH_PLUGINS}" >> ~/.zshrc
fi

echo "\noh-my-zsh plugins ready!"

# Setup spaceship prompt
begin_configuration "Spaceship Prompt"
echo "\nCloning spacheship prompt...\n"
git clone https://github.com/denysdovhan/spaceship-prompt.git \
    "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt"
ln -s "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" \
      "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"

# Set spaceship theme in zsh
prepend_file_with \
    $(cat ./spaceship-prompt-custom.txt)
    '~/.zshrc'

echo "\nSpaceship prompt good to go!\n"

# Download and install Fira-Code nerd font
begin_install "Fira-Code nerd font"
brew tap homebrew/cask-fonts
HOMEBREW_NO_AUTO_UPDATE=1 brew cask install font-fira-code
HOMEBREW_NO_AUTO_UPDATE=1 brew cask install font-firacode-nerd-font
report_install_success "Fira-Code"

# Download and install colorls
begin_install "colorls"
gem install colorls
report_install_success "colorls"

# Alias ls to use colorls
begin_configuration "colorls"
write_to_shell_config 'alias ls="colorls --sort-dirs"'
write_to_shell_config 'alias lc="colorls -t"'

echo "\ncolorls configured!\n"

# Source zsh-syntax-highlighting in LAST LINE OF ~/.zshrc
echo "\nsource ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
    >> ~/.zshrc

echo "\n\nDownloading custom terminal & iTerm themes...\n"
mkdir ~/Downloads/CustomTerminalThemes
mkdir ~/Downloads/CustomiTermThemes
# AtelierSulpherpool
curl -fsSL \
    https://raw.githubusercontent.com/lysyi3m/macos-terminal-themes/master/themes/AtelierSulphurpool.terminal \
    --output ~/Downloads/CustomTerminalThemes/AtelierSulphurpool.terminal
curl -fsSL \
    https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/AtelierSulphurpool.itermcolors \
    --output ~/Downloads/CustomiTermThemes/AtelierSulphurpool.itermcolors
# Cobalt2
curl -fsSL \
    https://raw.githubusercontent.com/lysyi3m/macos-terminal-themes/master/themes/Cobalt2.terminal \
    --output ~/Downloads/CustomTerminalThemes/Cobalt2.terminal
curl -fsSL \
    https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Cobalt2.itermcolors \
    --output ~/Downloads/CustomiTermThemes/Cobalt2.itermcolors
# MaterialDark
curl -fsSL \
    https://raw.githubusercontent.com/lysyi3m/macos-terminal-themes/master/themes/MaterialDark.terminal \
    --output ~/Downloads/CustomTerminalThemes/MaterialDark.terminal
curl -fsSL \
    https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/MaterialDark.itermcolors \
    --output ~/Downloads/CustomiTermThemes/MaterialDark.itermcolors
# SeaShells
curl -fsSL \
    https://raw.githubusercontent.com/lysyi3m/macos-terminal-themes/master/themes/SeaShells.terminal \
    --output ~/Downloads/CustomTerminalThemes/SeaShells.terminal
curl -fsSL \
    https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/SeaShells.itermcolors \
    --output ~/Downloads/CustomiTermThemes/SeaShells.itermcolors
# Spacedust
curl -fsSL \
    https://raw.githubusercontent.com/lysyi3m/macos-terminal-themes/master/themes/Spacedust.terminal \
    --output ~/Downloads/CustomTerminalThemes/Spacedust.terminal
curl -fsSL \
    https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Spacedust.itermcolors \
    --output ~/Downloads/CustomiTermThemes/Spacedust.itermcolors

echo "\nCustom terminal & iTerm themes downloaded. Don't forget to manually set them in-app!\n\n"

exit 0