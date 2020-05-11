# MacOS Automated Setup Script for Developers

This is a script for setting up a new Mac for developers.

## Installation

Clone or download this repo as a .zip file. Unzip it and run this command from the folder containing all these files:

```bash
./setup-mac.sh
```

## Details

Here is a full list of everything this script downloads, installs, and/or configures:

- Essential Command Line Tools:
    - xcode-command-line-tools
    - Homebrew
    - pkg-config
    - Git
    - Docker
    - Ruby
    - nvm, npm, npx
- Developer environment, Tools, and Languages
    - Python3, pip, virtualenv
    - NumPy, Pandas, SciKit, Matplotlib
    - Java 8 and Java 14
    - PHP7 and composer
    - Newer versions of GCC/G++ than ship with MacOS
    - AWS CLI
    - Firebase CLI
- Terminal Customizations
    - iTerm2
    - Use zsh as default shell
    - oh-my-zsh
        - Plugins: zsh-nvm, zsh-syntax-highlighting, git, brew, docker, zsh-autosuggestions
    - Custom fonts (Fira-Code Nerd Font)
    - Custom Spaceship prompt
    - ColorLs
    - Download custom themes for Terminal and iTerm (must be imported manually in-app)
    - Vim customizations
- IDEs
    - VisualStudioCode (see files for extensions and custom settings)
    - IntelliJ
    - PyCharm
    - WebStorm
    - PhpStorm
- Developer Tools
    - Postman
    - Wireshark
- Web Browsers
    - Google Chrome
    - Firefox Developers Edition
- Productivity Tools
    - Go2Shell
    - Clipy
    - The Unarchiver
    - Slack
    - Spotify
    - Zoom

## License

[MIT](https://choosealicense.com/licenses/mit/)