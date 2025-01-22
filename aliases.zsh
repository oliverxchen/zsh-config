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
alias docker_rm="podman ps -aq -f status=exited | xargs -r podman rm"
alias docker_rmi="podman images -q -f 'dangling=true' | xargs -r podman rmi"
alias docker_clean="docker_rm && docker_rmi"
