alias gc="git checkout"
alias gb="git branch"
alias gp="git pull"
alias gs="git status"
alias gl="git log"
alias oni="/Applications/Onivim2.App/Contents/MacOS/Oni2"
alias activate-conda="export PATH=$HOME/miniconda3/bin:$PATH"

gm() {
  if git branch | grep -q '^[* ]*master$'; then
    git checkout master
  else
    git checkout main
  fi
}
