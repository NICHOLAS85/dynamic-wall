#!/bin/sh

case $1/$2 in
#  pre/*)
#    echo "Going to $2..."
#    ;;
  post/*)
    echo "Waking up from $2..."
    echo "Triggering dynamicwall.sh..."
    dynamicwall -f
    ;;
esac
