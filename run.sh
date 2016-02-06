#!/bin/bash
if hash foo 2>/dev/null; then
  eval "$(rbenv init -)"
fi

cd /Users/adam/software/programming/rubomatic
bundle exec ruby rubomatic.rb
