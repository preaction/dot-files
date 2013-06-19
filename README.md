
# Vim

## Command-T

Command-T requires compilation

    cd vim/bundle/Command-T/ruby/command-t
    ruby extconf.rb
    make

Afterward, from inside vim:

    :call pathogen#helptags()

Be careful: Command-T will take some time to load initially!
