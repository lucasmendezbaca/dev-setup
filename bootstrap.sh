#!/usr/bin/env bash
set -euo pipefail

# ------------------------------
# Funciones auxiliares
# ------------------------------

install_nala() {
    echo "Instalando Nala..."
    sudo apt update
    sudo apt install -y nala
}

install_basic_packages() {
    echo "Instalando paquetes básicos..."
    sudo nala install -y \
        build-essential \
        unzip \
        ripgrep \
        fd-find \
        fzf \
        stow \
        tmux \
        tree-sitter-cli
}

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Configurar Brew en el PATH
    if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
}

install_neovim() {
    echo "Instalando Neovim via Brew..."
    brew install neovim
}

install_nerdfont() {
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip"
    TMP_ZIP="$(mktemp)"
    echo "Descargando Nerd Font..."
    curl -L "$FONT_URL" -o "$TMP_ZIP"
    echo "Descomprimiendo Nerd Font..."
    unzip -o "$TMP_ZIP" -d "$FONT_DIR"
    rm "$TMP_ZIP"
    fc-cache -fv
}

install_yazi() {
    echo "Instalando Yazi y dependencias..."
    brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font
}

install_zinit() {
    echo "Instalando Zinit si no existe..."
    ZINIT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
    if [ ! -d "$ZINIT_DIR" ]; then
        mkdir -p "$(dirname "$ZINIT_DIR")"
        git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_DIR"
    fi
}

setup_dotfiles() {
    echo "Configurando dotfiles con Stow..."
    DOTFILES_DIR="$HOME/dotfiles"

    if [ ! -d "$DOTFILES_DIR" ]; then
        echo "ERROR: No se encontró $DOTFILES_DIR. Clona tu repositorio primero."
        exit 1
    fi

    cd "$DOTFILES_DIR"
    stow zsh  # Aquí puedes agregar más carpetas según tu repositorio
}

# ------------------------------
# EJECUCIÓN
# ------------------------------
install_nala
install_basic_packages
install_homebrew
install_neovim
install_nerdfont
install_yazi
install_zinit
setup_dotfiles

echo "¡Bootstrap completado! Reinicia tu terminal o ejecuta 'source ~/.zshrc'."
