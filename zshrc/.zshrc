# Fo CTRL+Arrows key issue
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[3~" delete-char
# Automatically install zinit if it's not already installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat" wait"0" lucid
zinit light sharkdp/bat

zinit ice wait"0" lucid
zinit light zap-zsh/supercharge

# zsh-autosuggestions should generally be loaded last among plugins
zinit ice wait"0" lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Load and initialise completion system
autoload -Uz compinit
compinit
zinit cdreplay -q 

# starship
eval "$(starship init zsh)"

# nvim (Ubuntu)
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# fzf
source <(fzf --zsh)

# npm
export PATH="$HOME/.npm-global/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# use nvim for man
export MANPAGER="nvim +Man!"

# Load private secrets that aren't tracked in Git
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# bun completions
[ -s "/home/azeir/.bun/_bun" ] && source "/home/azeir/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias cat='bat --paging=never'

export PATH="/home/azeir/.pixi/bin:$PATH"
