set :rails_env, 'staging'
set :deploy_to, "/mnt/#{user}/apps/#{application}"
set :branch, 'develop'

server '1.1.1.1', :web, :app, :db, primary: true
