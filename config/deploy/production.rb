set :rails_env, 'production'
set :deploy_to, "/mnt/#{user}/apps/#{application}"
set :branch, 'master'

server '112.124.14.252', :web, :app, :db, primary: true