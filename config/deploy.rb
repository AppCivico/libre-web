# requires
require 'mina/rails'
require 'mina/rbenv'
require 'mina/git'

# basic settings:
set :version, 'v0.2.0'

set :application_name,  'libre-web'
set :domain,            ENV['MINA_DOMAIN'] || 'localhost'
set :deploy_to,         ENV['MINA_DEPLOY_DIR'] || '~/'
set :repository,        'https://github.com/eokoe/libre-web.git'
set :branch,            ENV['MINA_BRANCH'] || 'master'

# ssh settings:
set :user, ENV['MINA_SSH_USER'] || ''
set :forward_agent, true

###
# HACK: Middleman plugin for Mina deploy
###
set :middleman_bin, 'middleman'
set :middleman_build_path, 'build'
set :shared_dirs, fetch(:shared_dirs, []).push(fetch(:middleman_build_path))

namespace :middleman do
  desc 'Middleman build process.'
  task :build do
    command "#{fetch(:bundle_bin)} exec #{fetch(:middleman_bin)} build"
  end

  desc 'Show Middleman version.'
  task :version do
    command "#{fetch(:bundle_bin)} exec #{fetch(:middleman_bin)} version"
  end

  desc 'Clean Middleman build directory.'
  task :clean do
    comment 'Clear middleman build directories'
    command "rm -rf #{fetch(:middleman_build_path)}"
  end
end

# env settings
task :environment do
  invoke :'rbenv:load'
end

# Put any custom commands you need to run at setup
# all paths in `shared_dirs` and `shared_paths` will be created on their own.

task :setup do
  # command %{rbenv install 2.3.0}
end

desc 'Deploys the current version to the server.'
task :deploy do
  deploy do
    # invoke tasks
    invoke :'git:clone'
    invoke :'bundle:install'
    invoke :'middleman:build'

    on :launch do
      in_path(fetch(:current_path)) do
        command 'mkdir -p tmp/'
        command 'touch tmp/restart.txt'
      end
    end
  end

  run(:local) do
    puts 'DONE'
  end
end

# For help in making your deploy script, see the Mina documentation:
#  - https://github.com/mina-deploy/mina/tree/master/docs
