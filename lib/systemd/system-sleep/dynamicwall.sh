#!/bin/sh

case $1/$2 in
  post/*)
    echo "Triggering dynamicwall.sh..."
    dynamicwall
    ;;
esac
