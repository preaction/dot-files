# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallifrey"

# Set a custom dir outside of oh-my-zsh
# This allows us to keep oh-my-zsh as a submodule and still add more stuff
ZSH_CUSTOM="$HOME/dot-files/oh-my-zsh-custom"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(cpanm git-extras github zsh-syntax-highlighting git)

source $ZSH/oh-my-zsh.sh

######################################################################################
# Customize to your needs...
#

export EDITOR=vim
export LESS=RSXin~

alias :e=$EDITOR
alias :q=exit

# git-extras
export PATH="$HOME/dot-files/git-extras/bin:$PATH"
export MANPATH="$HOME/dot-files/git-extras/man:$MANPATH"

# Vi keybindings
bindkey -v
bindkey "^R" history-incremental-search-backward
# Emacs keybindings
#bindkey -e

# Bin scripts
if [[ -d /usr/local/bin ]]; then
    export PATH=/usr/local/bin:$PATH
fi
if [[ -d /usr/local/sbin ]]; then
    export PATH=/usr/local/sbin:$PATH
fi
if [[ -d $HOME/dot-files/bin ]]; then
    export PATH=$HOME/dot-files/bin:$PATH
fi
if [[ -d $HOME/bin ]]; then
    export PATH=$HOME/bin:$PATH
fi
if [[ -d $HOME/perl5/bin ]]; then
    export PATH=$HOME/perl5/bin:$PATH
fi

# Source perlbrew if installed
if [[ -e $HOME/perl5/perlbrew/etc/bashrc ]]; then
    source $HOME/perl5/perlbrew/etc/bashrc
fi

# Fix git perl scripts in case of local::lib
# If we install modules for a different arch in local::lib, we'll get some problems
if [[ -x /usr/bin/perl ]]; then
    GITPERLLIB=`/usr/bin/perl -MConfig -e'print join ":", grep { $_ } map { $Config{$_} } qw( sitearch sitelib vendorarch vendorlib )'`
    GITPERLLIB=/usr/local/lib/perl5/site_perl:$GITPERLLIB
fi
export GITPERLLIB

# Test::Pretty. Adjust color for solarized
export TEST_PRETTY_COLOR_NAME=Bright_Blue

# Less options
# -F -- Quit if less than a full screen. If less than a full terminal of data, behaves like cat
# -i -- Case-insensitive search by default (unless there is uppercase in the search string)
# -n -- No line numbers. If you need line numbers, use /vim?/
# -Q -- Really Quiet. Will never send a terminal bell ever
export PAGER="less -FinQ"

# ripgrep configuration file
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -e "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "$HOME/.goenv" ]; then
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    eval "$(goenv init -)"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"
fi

# Site-specific customizations
if [[ -f $HOME/.zshrc.after ]]; then
    source $HOME/.zshrc.after;
fi
