
set -o vi
export EDITOR="vim"
export PATH="$HOME/bin:$HOME/dot-files/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11"

if [ -n "$TMUX" ]; then
    preexec() {
        export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
        export "$(tmux show-environment | grep "^SSH_CONNECTION")"
    }
fi

if [ -d "$HOME/.goenv" ]; then
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    eval "$(goenv init -)"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"
fi

if [ -e "$HOME/.bash_profile.after" ]; then
    source "$HOME/.bash_profile.after";
fi

if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
