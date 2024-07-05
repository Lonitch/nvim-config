#!/bin/bash
# This file, while sets up your dev environment,
# is not battle-tested. Use it on your own risk
set -e

# Function to update Arch Linux mirrorlist
update_arch_mirrorlist() {
    echo "Updating Arch Linux mirrorlist..."
    sudo pacman -Sy --noconfirm reflector
    sudo reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
}

# Function to install packages quietly
install_package() {
    if command -v pacman &> /dev/null; then
        # For Arch Linux
        if ! sudo pacman -Syu --noconfirm "$@"; then
            echo "Error occurred during package installation. Attempting to update mirrorlist..."
            update_arch_mirrorlist
            sudo pacman -Syu --noconfirm "$@"
        fi
    elif command -v apt-get &> /dev/null; then
        sudo DEBIAN_FRONTEND=noninteractive apt-get update
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "$@"
    elif command -v yum &> /dev/null; then
        sudo yum install -y "$@"
    elif command -v brew &> /dev/null; then
        brew install "$@"
    else
        echo "Unsupported package manager. Please install $* manually."
        exit 1
    fi
}

# Function to detect Python pip command
get_pip_command() {
    if command -v pip3 &> /dev/null; then
        echo "pip3"
    elif command -v pip &> /dev/null; then
        echo "pip"
    else
        echo "pip command not found. Please install pip."
        exit 1
    fi
}

# Install prerequisites
echo "Installing prerequisites..."
install_package curl wget git bat ripgrep tmux zsh

# Set zsh as default shell
echo "Setting zsh as default shell..."
chsh -s "$(which zsh)"

# Install fzf from git
echo "Installing fzf from git..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Install nvm (Node Version Manager)
echo "Installing nvm..."
NVM_LATEST=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep "tag_name" | cut -d '"' -f 4)
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST}/install.sh" | bash
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js and npm using nvm
echo "Installing Node.js and npm..."
nvm install node
nvm use node

# Install bun
echo "Installing bun..."
curl -fsSL https://bun.sh/install | bash
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Install Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# shellcheck source=/dev/null
source "$HOME/.cargo/env"

# Install rustfmt and rust-analyzer
rustup component add rustfmt
rustup component add rust-analyzer

# Install leptosfmt
cargo install leptosfmt

# Install vscode-langservers-extracted
npm install -g vscode-langservers-extracted

# Install pyright
PIP_COMMAND=$(get_pip_command)
"$PIP_COMMAND" install pyright

# Install python-mode for Neovim
echo "Installing python-mode for Neovim..."
mkdir -p ~/.config/nvim/bundle
git clone https://github.com/python-mode/python-mode.git ~/.config/nvim/bundle/python-mode

# Install Quarto (latest version)
echo "Installing Quarto..."
QUARTO_LATEST=$(curl -s https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/^v//')
if command -v pacman &> /dev/null; then
    # For Arch Linux
    wget "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_LATEST}/quarto-${QUARTO_LATEST}-linux-amd64.tar.gz"
    tar -xzvf "quarto-${QUARTO_LATEST}-linux-amd64.tar.gz"
    sudo mv "quarto-${QUARTO_LATEST}" /opt/quarto
    sudo ln -s /opt/quarto/bin/quarto /usr/local/bin/quarto
    rm "quarto-${QUARTO_LATEST}-linux-amd64.tar.gz"
else
    # For Debian-based systems
    wget "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_LATEST}/quarto-${QUARTO_LATEST}-linux-amd64.deb"
    sudo dpkg -i "quarto-${QUARTO_LATEST}-linux-amd64.deb"
    rm "quarto-${QUARTO_LATEST}-linux-amd64.deb"
fi

# Copy configuration files
echo "Copying configuration files..."
cp .rustfmt.toml .zshrc .tmux.conf "$HOME/"

# Update PATH in .zshrc
{
    echo "export PATH=\"\$HOME/.bun/bin:\$PATH\""
    echo "export PATH=\"\$HOME/.fzf/bin:\$PATH\""
    echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'
    
    # Add Quarto to PATH for Arch Linux
    if command -v pacman &> /dev/null; then
        echo "export PATH=\"/opt/quarto/bin:\$PATH\""
    fi
} >> "$HOME/.zshrc"

echo "Setup complete! Please restart your shell or run 'source ~/.zshrc' to apply changes."
