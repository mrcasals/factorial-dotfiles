#!/bin/bash

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories

# Tree
if [ ! -x "$(which tree)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# GIT

# Aliases
alias gdiff='git diff master --compact-summary'
alias g="git status"
alias gst="git status"
alias gss="git status -sb"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -v"
alias gca="git commit -am"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gf="git fetch"
alias gm="git merge"
alias gr="git rebase"
alias gl="git log"
alias gs="git show"
alias gd="git diff"
alias gbl="git blame"
alias gps="git push"
alias gpl="git pull"
alias ggpush='git push origin "$(git_current_branch)"'
alias ggpull='git pull origin "$(git_current_branch)"'

function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function current_branch() {
  git_current_branch
}
