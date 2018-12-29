#!/bin/sh

case $1/$2 in
  pre/*)
    echo "Going to $2..."
    ;;
  post/*)
    echo "Waking up from $2..."
    echo "Triggering autowall.sh..."
    ./home/nicholas/bin/dynamic
    ;;
esac
