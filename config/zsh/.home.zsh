gcamp() {
    git commit -am "$1" && git push
}

# Add ctrl+r support with zsh-vi-mode
bindkey -M viins '^R' fzf-history-widget

alias gtparent='git config --get "git-town-branch.$(git rev-parse --abbrev-ref HEAD).parent"'
alias gtmerge="git rebase --onto main $(gtparent) $(git rev-parse --abbrev-ref HEAD) && git town kill $(gtparent)"
