#!/usr/bin/env bash

# import shared functions
source ./shared-functions.sh
if ["$?" != "0"]
then echo "Error importing shared functions.\n" && exit 1
fi

# Install Xcode command line tools
begin_install "Xcode command line tools"
xcode-select --install
report_install_success "Xcode command line tools"

# Install Homebrew
begin_install "Homebrew"
curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
brew update
report_install_success "homebrew"

export HOMEBREW_NO_AUTO_UPDATE=1

# Verify Homebrew installation success
echo "\nMaking sure Homebrew is up-to-date...\n"
brew update
brew doctor
brew --version
report_install_location "Homebrew" $(which brew)

# Tell bash and zsh to use Homebrew'd software instead of any default-installed
write_to_shell_config 'export PATH="/usr/local/bin:/usr/local/sbin:$PATH"'
typeset -U PATH

# Install GNU coreutils
begin_install "GNU coreutils"
brew install coreutils
report_install_success "GNU coreutils"

# Install gzip
begin_install "gzip"
brew intall gzip
report_install_success "gzip"

# Install unzip
begin_install "unzip"
brew install unzip
report_install_success "unzip"

# Install wget
begin_install "wget"
brew install wget
report_install_success "wget"

# Install pkg-config
begin_install "pkg-config"
brew cask pkg-config
report_install_success "pkg-config"
PKG_CONFIG_VERSION = $(pkg-config -- version)
echo "pkg-config version: ${PKG_CONFIG_VERSION}"
report_install_location "pkg-config" $(which pkg-config)

# Install git
begin_install "Git"
brew install git
report_install_success "Git"
git --version
report_install_location "git" $(which git)

# Configure global .gitignore
begin_configuration "global .gitignore"
cp ./static/.gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
report_command_success \
    "Successfully configured global .gitignore!\n" \
    "An error occurred configuring global .gitignore.\n"

# Install docker
begin_install "Docker"
brew cask install docker
report_install_success "Docker"
docker --version
report_install_location "docker" $(which docker)

# Configure docker completions
begin_install "Docker bash completions"
brew install bash-completion
brew install docker-completion

# Install ruby
begin_install "Homebrew version of Ruby"
brew install ruby
report_install_success "Ruby"
write_to_shell_config 'export PATH=/usr/local/Cellar/ruby/2.4.1_1/bin:$PATH'

# Install go
begin_install "Go"
mkdir -p ${HOME}/.go
mkdir -p ${GOPATH}/src/github.com
write_to_shell_config 'export GOPATH="${HOME}/.go"'
GO_BREW_PREFIX = $(brew -prefix golang)
write_to_shell_config "export GOROOT=${GO_BREW_PREFIX}/libexec"
write_to_shell_config 'export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"'
brew install go
report_install_success "golang"
go get golang.org/x/lint/golint


# Install nvm
begin_install "nvm (Node Version Manager)"
brew install nvm
report_install_success "nvm (Node Version Manager)"
NVM_VERSION = $(nvm --version)
echo "nvm version: ${NVM_VERSION}"
report_install_location "nvm" $(which nvm)

# Configure nvm
begin_configuration "nvm"
mkdir ~/.nvm    # Create a directory for nvm
write_to_shell_config 'export NVM_DIR=~/.nvm'
write_to_shell_config 'source $(brew --prefix nvm)/nvm.sh'
echo "\nView nvm directory by using command: 'echo \$NVM_DIR'\n"

# Use nvm to install node.js and npm
begin_install "Node.js and npm"
nvm install node
nvm install node
nvm install --lts
report_install_success "Node.js and npm"
echo "All installed node.js versions:\n"
nvm ls
NODE_VERSION = $(npm --version)
echo "\ncurrent node version: ${NODE_VERSION}"

# Install npx
begin_install "npx"
npm install -g npx
report_install_success "npx"
NPX_VERSION = $(npx --version)
echo "npx version: ${NPX_VERSION}"
report_install_location "npx" $(which npx)

exit 0