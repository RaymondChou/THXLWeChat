require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'rvm/capistrano'

set :rvm_ruby_string, '2.1.0'
set :stages, %w(staging production)
set :default_stage, 'staging'

load 'config/recipes/base'
load 'config/recipes/check'
load 'config/recipes/nginx'
load 'config/recipes/mysql'
load 'config/recipes/unicorn'
load 'config/recipes/couchbase'
load 'config/recipes/output'

set :application, 'thxl'
set :user, 'deployer'
set :deploy_via, :remote_cache
set :use_sudo, false
set :sudo, 'sudo'

set :scm, 'git'
set :repository, "git@github.com:iiseeuu/Buffet.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

before 'deploy:restart', 'deploy:migrate'

after 'deploy', 'deploy:cleanup'

after 'deploy' do
  `say -r 130 -v Zarvox Server have been deployed success`
end

before 'deploy' do
  `say -r 130 -v Zarvox Server deploy is starting - Now!`
end