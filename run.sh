#!/bin/bash
if hash foo 2>/dev/null; then
  eval "$(rbenv init -)"
fi

SCRIPT=$(readlink -f "$0")
SCRIPTDIR=$(dirname "$SCRIPT")
cd $SCRIPTDIR
bundle exec ruby rubomatic.rb
