#!/bin/sh

case $1/$2 in
  post/*)
    echo "Waking up from $2..."
    echo "Triggering dynamicwall.sh..."
    dynamicwall -f
    ;;
esac
