#!/bin/bash
set -e

: ${APP_PATH:="/app"}
: ${APP_TEMP_PATH:="$APP_PATH/tmp"}
: ${APP_SETUP_LOCK:="$APP_TEMP_PATH/setup.lock"}
: ${APP_SETUP_WAIT:="5"}

# 1: Define the functions lock and unlock our app containers setup
# processes:
function lock_setup { mkdir -p $APP_TEMP_PATH && touch $APP_SETUP_LOCK; }
function unlock_setup { rm -rf $APP_SETUP_LOCK; }
function wait_setup { echo "Waiting for app setup to finish..."; sleep $APP_SETUP_WAIT; }

# 2: 'Unlock' the setup process if the script exits prematurely:
trap unlock_setup HUP INT QUIT KILL TERM EXIT

# 3: Specify a default command, in case it wasn't issued:
if [ -z "$1" ]; then set -- rails server -p 5000 -b 0.0.0.0 "$@"; fi

# 4: Run the checks only if the app code is going to be executed:
if [[ "$1" = "rails" || "$1" = "sidekiq" || "$1" = "rspec" ]]
then
  # 5: Wait until the setup 'lock' file no longer exists:
  while [ -f $APP_SETUP_LOCK ]; do wait_setup; done

  # 6: 'Lock' the setup process, to prevent a race condition when the
  # project's app containers will try to install gems and setup the
  # database concurrently:
  lock_setup

  # 7: Check if the database exists, or setup the database if it doesn't,
  # as it is the case when the project runs for the first time.
  #
  # We'll use a custom script `check_db` (inside our app's `bin` folder),
  # instead of running `rails db:version` to avoid loading the entire rails
  # app for this simple check:
  echo "Checking db:version"
  rails db:version || bin/setup
  echo "Running migrations"
  rails db:migrate


  # 8: 'Unlock' the setup process:
  unlock_setup

  # 9: If the command to execute is 'rails server', then we must remove any
  # pid file present. Suddenly killing and removing app containers might leave
  # this file, and prevent rails from starting-up if present:
  if [[ "$2" = "s" || "$2" = "server" ]]; then rm -rf /app/tmp/pids/server.pid; fi
fi

# 10: Execute the given or default command:
exec "$@"

