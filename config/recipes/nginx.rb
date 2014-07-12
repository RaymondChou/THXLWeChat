namespace :nginx do
  desc "Install latest stable release of nginx."
  task :install, roles: :web do
    download = 'http://tengine.taobao.org/download/'
    pack = 'tengine-1.5.1.tar.gz'
    run "mkdir -p $HOME/downloads"
    run "cd $HOME/downloads && wget #{download}#{pack}"
    run "cd $HOME/downloads && tar -xvf #{pack} -C $HOME/"
    run "cd $HOME/tengine-1.5.1 && ./configure --with-http_gzip_static_module"
    run "cd $HOME/tengine-1.5.1 && make"
    run "cd $HOME/tengine-1.5.1 && #{sudo} make install"
  end
  after "deploy:install", "nginx:install"

  desc "Setup nginx configuration for this application."
  task :setup, roles: :web do
    template "nginx.conf.erb", "/tmp/nginx_conf"
    run "#{sudo} mv /tmp/nginx_conf /usr/local/nginx/conf/nginx.conf"
    template "nginx_unicorn.erb", "/tmp/nginx_unicorn"
    run "#{sudo} mkdir -p /usr/local/nginx/conf/sites-enabled"
    run "#{sudo} mv /tmp/nginx_unicorn /usr/local/nginx/conf/sites-enabled/#{application}"
    run "#{sudo} rm -f /usr/local/nginx/conf/sites-enabled/default"
    run "#{sudo} ln -nfs /usr/local/nginx/sbin/nginx /usr/local/bin/nginx"
    start
  end
  after "deploy:setup", "nginx:setup"

  desc 'start nginx'
  task :start, roles: :web do
    run "#{sudo} nginx"
  end

  desc 'restart nginx'
  task :restart, roles: :web do
    run "#{sudo} nginx -s reload"
  end
end