# dotfiles
Easily build an environment with dotfiles.

## Development environment
|              |  My Environment  　　|
|:---:|:---:|
|OS|MacOS|
|shell|fish|
|Terminal|iTerm2|
|Code Editor|Visual Studio Code|

## How to Set up
`$ cd ~`  
`$ git clone https://github.com/HikaruKobayashi/dotfiles.git`

### fish
`$ cd dotfiles`  
`$ sh setup.sh`

### Visual Studio Code
`$ cd vscode`  
`$ sh vscode.sh`

### iTerm2
- Launch iTerm2 and open Preferences.  
- General > Preferences > Check "Load preferences from a custom folder or URL"  
- Push "Browse" button and set folder to ~/dotfiles/iTerm2

### Brewfile
`$ brew tap Homebrew/bundle`  
`$ brew bundle --file=Brewfile/Brewfile`
