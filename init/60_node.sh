# Load nave- and npm-related functions.
source $DOTFILES/source/60_node.sh

# Install latest stable Node.js, set as default, install global npm modules.
nave_install stable

nave usemain stable

npm install -g npm
