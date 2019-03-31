#!/bin/sh

# sigint_handler()
# {
#   echo "attempt to kill"
#   kill $PID
#   exit
# }

# trap sigint_handler SIGINT

COMMAND="/usr/local/bin/php index.php"
while true; do
  /usr/local/bin/php index.php &
  # $COMMAND &
  PID=$!
  echo "new pid"
  echo $PID
  # ps aux | grep php
  echo "$!" > file.pid
  inotifywait -e modify -e move -e create -e delete -e attrib -r `pwd`
  echo "killing"
  echo $PID
  # kill -9 $PID
  pkill php
done
