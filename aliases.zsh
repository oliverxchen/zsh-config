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

gc() {
  git branch --merged main | grep -v '^\*' | grep -v ' main$' | xargs -n 1 git branch -d
  git fetch --all --prune
}


alias docker="podman"
alias docker_rm="podman ps -aq -f status=exited | xargs -r podman rm"
alias docker_rmi="podman images -q -f 'dangling=true' | xargs -r podman rmi"
alias docker_clean="docker_rm && docker_rmi"

alias login_all="gcloud auth application-default login && gcloud auth login && firebase login --reauth"
