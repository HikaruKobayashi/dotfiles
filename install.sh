#!/bin/sh
set -ue

# vscode
echo "vscode"

VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

if [ -L "${VSCODE_SETTING_DIR}/settings.json" ]; then
  rm "${VSCODE_SETTING_DIR}/settings.json"
fi
ln -s ~/dotfiles/vscode/settings.json "${VSCODE_SETTING_DIR}/settings.json"

if [ -L "${VSCODE_SETTING_DIR}/keybindings.json" ]; then
  rm "${VSCODE_SETTING_DIR}/keybindings.json"
fi
ln -s ~/dotfiles/vscode/keybindings.json "${VSCODE_SETTING_DIR}/keybindings.json"

cat < ./vscode/extensions | while read -r line
do
  code --install-extension "$line"
done
code --list-extensions > extensions

# Homebrew
echo "Homebrew setting"

if [ ! -f /usr/local/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ ! -d ~/dotfiles ]; then
  cd ~
  git clone https://github.com/HikaruKobayashi/dotfiles.git
fi

brew bundle -v --file=~/dotfiles/Brewfile/Brewfile

# fish shell
sudo sh -c 'echo $(which fish) >> /etc/shells'
sh -c 'chsh -s $(which fish)'
rm -rf ~/.config/fish
ln -fs ~/dotfiles/fish ~/.config
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# nvim
rm -rf ~/.config/nvim
ln -fs ~/dotfiles/nvim ~/.config

# asdf plugin install
echo "asdf setting"
log() {
  message=$1
  echo "$message"
}
is_dir() {
  path=$1
  [ -d "$path" ]
}

for plugin in $(awk '{print $1}' ~/.tool-versions); do
  if ! is_dir ~/.asdf/plugins/"$plugin"; then
    asdf plugin add "$plugin"
  fi
done

is_runtime_versions_changed() {
  plugin="$1"
  specified=$(grep "$plugin" ~/.tool-versions | awk '
  {$1=""; print $0}')

  installed=$(asdf list "$plugin" 2>&1)

  is_changed=
  for version in $specified; do
    match=$(echo "$installed" | grep "$version")
    [ -z "$match" ] && is_changed=1
  done

  [ "$is_changed" ]
}

for plugin in $(asdf plugin list); do
  if is_runtime_versions_changed "$plugin"; then
    if [ "$plugin" = nodejs ]; then
      log "Import release team keyring for Node.JS"
      bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-previous-release-team-keyring'
    fi
    log "Install runtime: $plugin"
    asdf install "$plugin"
  fi
done

print_header() {
  printf "\e[34m"
  echo '--------------------------------------------------------------------------------'
  echo '                                                                                '
  echo '                 888          888     .d888 d8b 888                             '
  echo '                 888          888    d88P"  Y8P 888                             '
  echo '                 888          888    888        888                             '
  echo '             .d88888  .d88b. 8888888 888888 888 888  .d88b.  .d8888b            '
  echo '            d88" 888 d88""88b 888    888    888 888 d8P  Y8b 88K                '
  echo '            888  888 888  888 888    888    888 888 88888888 "Y8888b.           '
  echo '            Y88b 888 Y88..88P Y88b.  888    888 888 Y8b.          X88           '
  echo '             "Y88888  "Y88P"   "Y888 888    888 888  "Y8888   88888P"           '
  echo '                                                                                '
  echo '                           comfortable envs for you                             '
  echo '                                                                                '
  echo '                         github.com/HikaruKobayashi/dotfiles                    '
  echo '                                                                                '
  echo '--------------------------------------------------------------------------------'
  printf "\e[0m\n"
}