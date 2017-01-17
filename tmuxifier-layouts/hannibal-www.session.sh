# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work/servercentral/hannibal-www"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "hannibal-www"; then

  new_window "edit"
  new_window "test"

  new_window "app"
  tmux split-window -t "$session:$window.0" -v -p 50
  tmux split-window -t "$session:$window.0" -h -p 50
  tmux split-window -t "$session:$window.2" -h -p 50
  tmux send-keys -t "$session:$window.0" C-z "cd $session_root; postgres -D db" Enter
  tmux send-keys -t "$session:$window.1" C-z "cd $session_root; elasticsearch" Enter
  tmux send-keys -t "$session:$window.2" C-z "cd $session_root/../hannibal-cia; carton exec morbo script/hannibal -l http://*:3000" Enter
  tmux send-keys -t "$session:$window.3" C-z "cd $session_root; carton exec morbo script/hannibal-www -l http://*:3001" Enter

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
