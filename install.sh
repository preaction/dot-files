for LINK in dzil gitconfig gitignore jshintrc oh-my-zsh oh-my-zsh-custom perlcriticrc perltidyrc proverc tmux.conf vim vimrc zshrc; do ln -s $(pwd)/$LINK $HOME/.$LINK; done
