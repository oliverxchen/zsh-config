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
  git branch --merged main \
    | sed 's/^[*+ ]*//' \
    | grep -v '^main$' \
    | while read -r branch; do
        git branch -d "$branch"
      done

  git fetch --all --prune
}

login_all() {
  if ! (gcloud auth application-default login && gcloud auth login && firebase login --reauth); then
    echo "If you get: \`ERROR: There was a problem with web authentication.\`, try to invoke the command \`gcloud auth revoke --all\` and run \`login_all\` again"
  fi
}

alias docker="podman"
alias docker_rm="podman ps -aq -f status=exited | xargs -r podman rm"
alias docker_rmi="podman images -q -f 'dangling=true' | xargs -r podman rmi"
alias docker_clean="docker_rm && docker_rmi"

