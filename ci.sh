#!/bin/bash

# global variables
# FOR DEVELOPMENT USE:APP_DIR=$(pwd)
APP_DIR=/home/jenkis/apps/libre/dev.libre.build


###################################################
# CHANGE TO DIRECTORY
###################################################
echo "=== CHANGING DIRECTORY"
echo "    - access directory path: '$APP_DIR'"
cd $APP_DIR


###################################################
# CONFIGURE RBENV
###################################################
echo "=== RBENV CONFIGURATION"
export PATH="$HOME/.rbenv/bin:$PATH";
eval "$(rbenv init -)"
echo "    - rbenv version: $(rbenv --version)"


###################################################
# INSTALL RUBY DEPS
###################################################
echo "=== INSTALL RUBY GEMS"
rbenv local 2.3.1
echo "    - ruby version: $(rbenv version)"
gem install bundler
echo "    - bundle version: $(bundle --version)"
bundler install


###################################################
# INSTALL NODE DEPS
###################################################
echo "=== INSTALL NODE MODULES USING YARN"
if [ -f .nvmrc ]; then
	nvm install
	nvm use
fi
echo "    - node version: node $(node --version)"
echo "    - npm version: npm $(npm --version)"
echo "    - install yarn tool using npm"
npm install yarn
echo "    - resolve application dependencies using yarn version: $(yarn --version)"
yarn install


###################################################
# RUN MIDDLEMAN BUILD TASK
###################################################
echo "=== RUN MIDDLEMAN BUILD TASK"
echo "    - middleman version: $(bundle exec middleman version)"
LOGGY_STACKS=1
bundle exec middleman build --environment development --verbose


