#!/bin/bash

export PATH="$HOME/.rbenv/bin:$PATH";
eval "$(rbenv init -)"

cd /home/jenkis/apps/libre/dev.libre.build;
rbenv local 2.3.1
bundler install
bundler exec middleman build
