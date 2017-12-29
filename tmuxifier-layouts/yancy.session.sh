# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/perl/Yancy"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "yancy"; then

  new_window "code"

  new_window "test"
  tmux split-window -t "$session:$window.0" -v -p 50
  tmux send-keys -t "$session:$window.0" "cd $session_root; export MOJO_HOME=eg; export PERL5LIB=lib:$PERL5LIB; morbo bin/yancy --watch $session_root" Enter
  tmux send-keys -t "$session:$window.1" "cd $session_root; export TEST_ONLINE_MYSQL=mysql://localhost/yancy_mysql_test" Enter
  tmux send-keys -t "$session:$window.1" "cd $session_root; export TEST_ONLINE_PG=postgres://localhost/test" Enter
  tmux send-keys -t "$session:$window.1" "cd $session_root; export TEST_ONLINE_SQLITE=sqlite:db/sqlite/test.db" Enter

  new_window "db"
  tmux split-window -t "$session:$window.0" -v -p 50
  tmux send-keys -t "$session:$window.0" "cd $session_root; postgres -D db/pg" Enter
  tmux send-keys -t "$session:$window.1" "cd $session_root; mysqld --skip-grant-tables --datadir=db" Enter

  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
