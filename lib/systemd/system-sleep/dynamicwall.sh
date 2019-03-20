#!/bin/sh

case $1/$2 in
#  pre/*)
#    echo "Going to $2..."
#    ;;
  post/*)
    echo "Waking up from $2..."
    echo "Triggering dynamicwall.sh..."
    systemctl start dynamicwall.service
    ;;
esac
