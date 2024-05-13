gcamp() {
    git commit -am "$1" && git push
}

# Add ctrl+r support with zsh-vi-mode
bindkey -M viins '^R' fzf-history-widget
