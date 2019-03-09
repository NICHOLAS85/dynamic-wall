#!/bin/sh
usrnm=$(grep -i ':x:1000:' -A 0 /etc/passwd | sed 's/:x:1000:.*//')
case $1/$2 in
  pre/*)
    echo "Going to $2..."
    ;;
  post/*)
    echo "Waking up from $2..."
    echo "Triggering autowall.sh..."
    systemctl start autowall.service
    ;;
esac
