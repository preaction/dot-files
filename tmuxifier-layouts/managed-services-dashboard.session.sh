# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/work/servercentral/ManagedServicesDashboard"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "managed-services-dashboard"; then

  new_window "code"

  new_window "test"
  tmux split-window -t "$session:$window.0" -v -p 50
  tmux send-keys -t "$session:$window.0" "cd $session_root; export PERL5LIB=lib:$PERL5LIB; morbo script/dashboard" Enter

  new_window "db"
  tmux send-keys -t "$session:$window.0" "cd $session_root; redis-server /usr/local/etc/redis.conf" Enter

  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
