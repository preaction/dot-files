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
plugins=(cpanm git-extras github zsh-syntax-highlighter git)

source $ZSH/oh-my-zsh.sh

######################################################################################
# Customize to your needs...
#

export EDITOR=vim
export LESS=RSXin

# Fix git-completion for BofA
zstyle ':completion:*:*:git:*' script $HOME/dot-files/complete/git-completion.bash
fpath=($HOME/dot-files/zsh $fpath)

# git-extras
export PATH="$HOME/dot-files/git-extras/bin:$PATH"
export MANPATH="$HOME/dot-files/git-extras/man:$MANPATH"

# Tmuxifier
export PATH="$HOME/dot-files/tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# Vi keybindings
bindkey -v
# Emacs keybindings
bindkey -e

# Bin scripts
if [[ -d $HOME/dot-files/bin ]]; then
    export PATH=$HOME/dot-files/bin:$PATH
fi
if [[ -d $HOME/bin ]]; then
    export PATH=$HOME/bin:$PATH
fi

# Fix git perl scripts in case of local::lib
# If we install modules for a different arch in local::lib, we'll get some problems
if [[ -x /usr/bin/perl ]]; then
    GITPERLLIB=`/usr/bin/perl -MConfig -e'print join ":", grep { $_ } map { $Config{$_} } qw( sitearch sitelib vendorarch vendorlib )'`
    GITPERLLIB=/usr/local/lib/perl5/site_perl:$GITPERLLIB
fi
export GITPERLLIB

# Test::Pretty. Adjust color for solarized
export TEST_PRETTY_COLOR_NAME=bright_yellow

# Site-specific customizations
if [[ -f $HOME/.zshrc.after ]]; then
    source $HOME/.zshrc.after;
fi

# START TMUX SESSION
if [[ "$TERM" != "screen" && "$TERM" != "screen-256color" && -x `which tmux` ]]; then
    tmx login
fi

