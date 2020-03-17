ulimit -n 10000

# bash-git-prompt
if [ "$(which brew)" != "" ]; then
  if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
  fi
fi

# git-completion bash
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
