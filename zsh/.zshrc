# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# ZINIT (plugin manager)
# ------------------------------

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Descargar Zinit si no existe
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Cargar Zinit
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------
# POWERLEVEL10K THEME
# ------------------------------

zinit ice depth=1
zinit light romkatv/powerlevel10k

# Cargar configuración de Powerlevel10k si existe
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ------------------------------
# PLUGINS ESENCIALES
# ------------------------------

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# ------------------------------
# COMPLETIONS
# ------------------------------

autoload -Uz compinit
compinit

# ------------------------------
# HISTORIAL
# ------------------------------

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups

# ------------------------------
# OPCIONES ÚTILES
# ------------------------------

setopt autocd            # cd sin escribir cd
setopt interactivecomments

# ------------------------------
# ALIASES
# ------------------------------

alias ll="ls -lah"
alias vim="nvim"
alias c="clear"

# ------------------------------
# PACKAGE MANAGER Homebrew
# ------------------------------
if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ------------------------------
# Priorizar Brew en el PATH
# ------------------------------
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# ------------------------------
# EDITOR POR DEFECTO
# ------------------------------

export EDITOR="nvim"

# ------------------------------
# Yazi shell wrapper
# ------------------------------
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

