alias gc="git checkout"
alias gb="git branch"
alias gp="git pull"
alias gs="git status"
alias gl="git log"

gm() {
  if git branch | grep -q '^[* ]*master$'; then
    git checkout master
  else
    git checkout main
  fi
}

alias docker="podman"
