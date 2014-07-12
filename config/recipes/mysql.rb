namespace :mysql do
  desc "Install latest stable release of mysql."
  task :install, roles: :web do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install mysql-client-core-5.5 mysql-client-5.5 libmysqlclient-dev"
  end
  after "deploy:install", "mysql:install"

  task :create_database do
    run "cd #{release_path}; bundle exec rake db:create RAILS_ENV=#{rails_env}"
  end
  #after "bundle:install", "mysql:create_database", "deploy:migrate"

  desc "config database.yml"
  task :config_database do
    run "cp #{release_path}/config/database.yml.example #{release_path}/config/database.yml"
  end
  before "deploy:assets:precompile", "mysql:config_database"

  %w[start stop restart].each do |command|
    desc "#{command} mysql."
    task command, roles: :web do
      run "#{sudo} service mysql #{command}"
    end
  end
end