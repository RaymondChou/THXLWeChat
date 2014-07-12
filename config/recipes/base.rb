def template(from, to)
  erb = File.read(File.dirname(__FILE__) + "/templates/#{from}")
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  task :install do
    run "#{sudo} apt-get -y update", :shell => :bash
    run "#{sudo} apt-get -y install python-software-properties curl git-core gawk g++ gcc make libc6-dev libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev zip wget libpcre3-dev", :shell => :bash

    run "#{sudo} add-apt-repository -y ppa:chris-lea/node.js", :shell => :bash
    run "#{sudo} apt-get -y update", :shell => :bash
    run "#{sudo} apt-get -y install nodejs", :shell => :bash
  end
  after "deploy:install", "rvm:install_rvm"
  after "rvm:install_rvm", "rvm:install_ruby"
  after "deploy:rvm_source_change", "rvm:install_ruby"
  after "rvm:install_ruby", "deploy:rvm_use"

  task :rvm_source_change do
    run "sed -i 's!ftp.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' /mnt/deployer/.rvm/config/config/db"
  end

  task :rvm_use do
    run "bash --login && rvm use 2.1.0"
    run "gem sources --remove https://rubygems.org/"
    run "gem sources --remove http://rubygems.org/"
    run "gem sources -a http://ruby.taobao.org/"
    run "gem install bundler"
  end

  desc "reload the database with seed data, danger!!"
  task :seed_fu do
    run "cd #{current_path}; bundle exec rake db:seed_fu RAILS_ENV=#{rails_env}"
  end

end

