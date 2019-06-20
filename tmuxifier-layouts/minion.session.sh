# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/perl/Minion"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "minion"; then

  new_window "code"

  new_window "daemon"
  tmux split-window -t "$session:$window.0" -v -p 50
  tmux send-keys -t "$session:$window.1" "cd $session_root; postgres -D db" Enter

  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
