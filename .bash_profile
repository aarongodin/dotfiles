ulimit -n 10000

# bash-git-prompt
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# Functions

function tma() {
  tmux attach -t $1
}

function tml() {
  tmux list-sessions
}

function tmn() {
  tmux new -s $1
}

function rm-swap {
  # Recursively remove vim swap files
  find . -name "*.swp" -print0 | xargs -0 rm -rf
}

function l {
  ls -Gp
}

function ll {
  ls -alhGp
}

function gc {
  git commit -am $1
}

function gs {
  git status
}

function gpom {
  git push origin master
}

function gpod {
  git push origin develop
}

function gpor {
  git push origin release
}

# Best Buy
export PATH=$HOME/.binctl:~/.bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
