#!/usr/bin/env bash

# Constants
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

begin_deploy() {
    echo
    echo
    echo "${BOLD}############## $1 ##############${NORMAL}"
}

begin_install() {
    echo
    echo "Installing ${BOLD}$1${NORMAL}..."
}

begin_configuration() {
    echo
    echo "Configuring ${BOLD}$1${NORMAL}..."
}

error_exit()
{

#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------


	echo "${RED}${1:-"Unknown Error"}${RESET}" 1>&2
	exit 1
}

report_command_success()
{
#	----------------------------------------------------------------
#	Function to determine if last command completed with status code 0.
#   Reports error message on failure, or success message on success.
#		Accepts 2 arguments:
#			string containing descriptive success message
#           string containing descriptive error message
#	----------------------------------------------------------------
    if ["$?" == "0"]
    then echo "${GREEN}${1:-"Command successful"}${RESET}" && exit 0
    else echo "${RED}${1:-"Unknown Error"}${RESET}" 1>&2
    fi
}

report_install_success()
{
#	----------------------------------------------------------------
#	Function to determine if last installation completed with status code 0.
#   A more specific version of report_command_success for software/package installations.
#   Reports error message on failure, or success message on success.
#		Accepts 1 arguments:
#			The name of the program installed during last command.
#	----------------------------------------------------------------
    if ["$?" == "0"]
    then echo "${GREEN}Successfully installed ${1}!${RESET}\n" && exit 0
    else echo "${RED}Error installing ${1}.${RESET}\n"
    fi
}

assert_command_success()
{

#	----------------------------------------------------------------
#	Function to assert that last command completed with status code 0.
#   Reports error message on failure, or success message on success.
#		Accepts 2 arguments:
#			string containing descriptive success message
#           string containing descriptive error message
#	----------------------------------------------------------------
    if ["$?" == "0"]
    then echo "${GREEN}${1:-"Command successful"}${RESET}" && exit 0
    else error_exit "${2}"
    fi
}

assert_install_success()
{

#	----------------------------------------------------------------
#	Function to assert that last installation completed with status code 0.
#   A more specific version of report_command_success for software/package installations.
#   Reports error message on failure, or success message on success.
#		Accepts 1 arguments:
#			The name of the program installed during last command.
#	----------------------------------------------------------------
    if ["$?" == "0"]
    then echo "${GREEN}Successfully installed ${1}!${RESET}\n" && exit 0
    else error_exit "${RED}Error installing ${1}.${RESET}\n"
    fi
}

report_install_location()
{
#	----------------------------------------------------------------
#	Function to print the (bash default) location of an installed software. 
#		Accepts 2 arguments:
#			The name of the software.
#           The location of the software.
#	----------------------------------------------------------------
    echo "${1} installed at location ${2}.\n"
}

write_to_shell_config()
{
#	----------------------------------------------------------------
#	Function to echo a string into both the ~/.bash_profile and ~/.zshrc
#		Accepts 1 argument:
#			The string to write into the configuration files.
#	----------------------------------------------------------------
    echo "\n${1}\n" >> ~/.bash_profile
    echo "\n${1}\n" >> ~/.zshrc
}

prepend_file_with()
{
#	----------------------------------------------------------------
#	Function to write a string into the first line of a file
#		Accepts 2 arguments:
#			The string to prepend into file.
#           The path to the file to write into.
#	----------------------------------------------------------------
    sed -i "1s/^/${1}/" ${2}
}