#!/usr/bin/env bash

# import shared functions
source ./shared-functions.sh
if ["$?" != "0"]
then echo "Error importing shared functions.\n" && exit 1
fi

# Install python and pip
begin_install "python3 and pip"
HOMEBREW_NO_AUTO_UPDATE=1 brew install python
report_install_success "python3 and pip"
report_install_location "python3" $(which python3)
python3 --version
pip3 --version

# Intall virtualenv
begin_install "virtualenv"
pip install virutalenv
report_install_success "virtualenv"

# Install NumPy and Pandas
begin_install "NumPy and Pandas"
pip install numpy
report_install_success "NumPy"
pip install pandas
report_install_success "Pandas"

# Install SciKit
begin_install "SciKit"
HOMEBREW_NO_AUTO_UPDATE=1 brew cask install gfortran
report_install_success "gfortran"
pip install scipy
report_install_success "SciSkit"

# Install Matplotlib
begin_install "Matplotlib"
pip install matplotlib
report_install_success "Matplotlib"

# Install Black (python code reformatter)
begin_install "Black (the uncompromising python code formatter)"
pip install black
report_install_success "Black (the uncompromising python code formatter)"

# Install Java 8 and Java 14
begin_install "Java 8 and Java 14"
brew tap adoptopenjdk/openjdk
HOMEBREW_NO_AUTO_UPDATE=1 brew cask install adoptopenjdk8
report_install_success "Java 8"
HOMEBREW_NO_AUTO_UPDATE=1 brew cask install adoptopenjdk14
report_install_success "Java 14"

# Set java_home to be Java 14 in bash and zsh
write_to_shell_config "export JAVA_HOME='/usr/libexec/java_home -v14'"

# Install maven
begin_install "Maven"
HOMEBREW_NO_AUTO_UPDATE=1 brew install maven
report_install_success "maven"

# Install Homebrew latest version of gcc and g++
begin_install "GCC and G++"
HOMEBREW_NO_AUTO_UPDATE=1 brew install gcc
report_install_success "GCC and G++"
gcc-9 --version

# Make sure bash/zsh use Homebrew gcc instead of Clang
write_to_shell_config 'alias gcc="gcc-9'

# Install php7
begin_install "php7"
HOMEBREW_NO_AUTO_UPDATE=1 brew install php
report_install_success "php7"

# Install composer
begin_install "composer"
HOMEBREW_NO_AUTO_UPDATE=1 brew install composer
report_install_success "composer"

# Install prettier and official plugins
begin_install "prettier and official plugins"
npm install -g prettier @prettier/plugin-php
report_install_success "prettier and official plugins"

# Install prettier community plugins
begin_install "prettier community plugins"
npm install -g prettier-plugin-java prettier-plugin-organize-imports
report_install_success "prettier community plugins"

# Install cloc (count lines of code)
begin_install "cloc (count lines of code)"
npm install -g cloc
report_install_success "cloc"

# Install Firebase cli
begin_install "Firebase cli"
curl -sL https://firebase.tools | bash
report_install_success "Firebase cli"

# Install AWS cli
begin_install "AWS cli (v2)"
HOMEBREW_NO_AUTO_UPDATE=1 brew install awscli
# Give permissions to pkgconfig
chmod 755 /usr/local/lib/pkgconfig

exit 0