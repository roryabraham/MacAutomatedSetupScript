#!/usr/bin/env bash

# import shared functions
source ./shared-functions.sh
if ["$?" != "0"]
then echo "Error importing shared functions.\n" && exit 1
fi

# ===============================

begin_deploy "COMMAND LINE UTILS"
bash ./install-cmd-line-tools.sh

export HOMEBREW_NO_AUTO_UPDATE=1

# ===============================

begin_deploy "DEVELOPMENT ENVIRONMENT"
bash ./setup-dev-env.sh

# ===============================

begin_deploy "TERMINAL CUSTOMIZATION"
bash ./customize-terminal.sh

# ===============================

begin_deploy "VIM CUSTOMIZATION"
bash ./customize-vim.sh

# ===============================

begin_deploy "IDEs"
# Download and install visual studio code
begin_install "Visual Studio Code"
brew cask install visual-studio-code
report_install_success "Visual Studio Code"

# Setup `code` command-line invocation of vs-code
begin_configuration "Visual Studio Code"
cat << EOF >> ~/.bash_profile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
cat << EOF >> ~/.zshrc
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

# install vs-code extensions
cat ./static/vscode-extensions.txt | xargs -L1 code --install-extension

# configure vs-code custom settings
cp ./static/vscode-custom-settings.json "$HOME/Library/Application Support/Code/User/settings.json"

# Download and install JetBrains toolsuite
begin_install "JetBrains Toolbox"
brew cask install jetbrains-toolbox
report_install_success "JetBrains Toolbox"

begin_install "IntelliJ IDEA"
brew cask install intellij-idea
report_install_success "IntelliJ IDEA"

begin_install "WebStorm"
brew cask install webstorm
report_install_success "WebStorm"

begin_install "PhpStorm"
brew cask install phpstorm
report_install_success "PhpStorm"

begin_install "PyCharm"
brew cask install pycharm
report_command_success "PyCharm"

# ===============================

begin_deploy "DEVELOPER TOOLS"

begin_install "MAMP"
brew cask install mamp
report_install_success "MAMP"

begin_install "PhpMyAdmin"
brew cask install phpmyadmin
report_install_success "PhpMyAdmin"

begin_install "PgAdmin4"
brew cask install pgadmin4
report_install_success "PgAdmin4"

begin_install "Postman"
brew cask install postman
report_install_success "Postman"

begin_install "Wireshark"
brew cask install wireshark
report_install_success "Wireshark"

# ===============================

begin_deploy "WEB BROWSERS"

begin_install "Google Chrome"
brew cask install google-chrome
report_install_success "Google Chrome"

begin_install "FireFox Developer Edition"
brew cask install firefox-developer-edition
report_install_success "FireFox Developer Edition"

# ===============================

begin_deploy "PRODUCTIVITY TOOLS"

begin_install "Go2Shell"
brew cask install go2shell
report_install_success "Go2Shell"

begin_install "Clipy"
brew cask install clipy
report_install_success "Clipy"

begin_install "The Unarchiver"
brew cask install the-unarchiver
report_install_success "The Unarchiver"

begin_install "Slack"
brew cask install slack
report_install_success "Slack"

begin_install "Spotify"
brew cask install spotify
report_install_success "Spotify"

begin_install "Zoom"
brew cask install zoomus
report_install_success "Zoom"

# ===============================

begin_deploy "CLEANING UP"
typeset -U PATH
brew cleanup
