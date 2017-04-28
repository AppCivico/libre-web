#!/bin/bash

# change to dir
cd /home/jenkis/apps/libre/dev.libre.build;


# configure rbenv
export PATH="$HOME/.rbenv/bin:$PATH";
eval "$(rbenv init -)"


# install ruby deps
rbenv local 2.3.1
gem install bundler
bundler install


# install node deps
# TODO: install and use nodeenv https://github.com/ekalinin/nodeenv
npm install yarn
yarn install


# run middleman build task
bundle exec middleman build --environment production
