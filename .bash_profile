ulimit -n 2000

# NVM
[ -s "/Users/a6001410/.nvm/nvm.sh" ] && . "/Users/a6001410/.nvm/nvm.sh"

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

function tms() {
	tmux switch -t $1
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

function psql {
	/Applications/Postgres.app/Contents/Versions/9.5/bin/psql -p5432
}

function nw {
  ~/bin/nwjs/nwjs.app/Contents/MacOS/nwjs $1
}

export PATH=$HOME/.binctl:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

