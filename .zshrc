# general
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../../'
alias ......='cd ../../../../../../'

alias be='bundle exec'
alias c='clear'
alias e='emacs -nw'
alias emacs='emacs -nw'
alias ls='ls -aG'
alias update="bundle i && yarn install && bin/rails db:migrate:primary RAILS_ENV=development"
alias v='vim $(fzf --height 40% --reverse)'

# yarn subs lol
alias yp='yarn prettier-write'
alias yg='yarn graphql-schema'
alias strict="yarn tsc-strict"

# tmux
alias tat="tmux a -t"

# git
alias ga='git add'
alias gb='git branch -vv'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gcv='git commit -v'
alias gd='git diff'
alias glo='git log --oneline -n 50'
alias gp='git pull'
alias gr='git restore'
alias grc='git rebase --continue'
alias grs='git restore --staged'
alias gs='git status'
alias gsl='git stash list'
alias master='git checkout master'

# fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden -g !.git -g !vendor/bundle'
fi

alias cbn='git branch --show-current | pbcopy' # copy branch name to clipboard
alias dcb='git branch --show-current | pbcopy && git checkout master && pbpaste | xargs git branch -D' # delete current branch
alias fgb='git branch | fzf | xargs git checkout' # fuzzy git branch; switch to branch upon select

# linter autocorrect uncommitted changes
alias lint="gd master --name-only | grep '.ts\|.js' | xargs npx eslint --fix"
alias cop="gd master --name-only | grep '\.rb$' | xargs rubocop -A"

# bind up and down to only search history starting with the typed-in substring
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# find and set branch name variable if in git repo
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
      echo -n $branch && echo ' '
  fi
}

# enable substitution in the prompt
setopt prompt_subst

# customize prompt
PROMPT='%F{cyan}%1~%f %F{green}$(git_branch_name)%f'

# path
export PATH=$HOME/.rbenv/shims:$PATH # MT
export PATH=$HOME/.cargo/env:$PATH # Rust
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt:$PATH"

# start
eval "$(fnm env --use-on-cd)" # https://github.com/Schniz/fnm hehehe
eval "$(rbenv init - zsh)"
