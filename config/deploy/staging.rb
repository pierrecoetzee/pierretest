set :application, "Pierretest"
set :repository, "https://github.com/pierrecoetzee/pierretest.git"
default_run_options[:pty] = true 

set :deploy_via, :remote_cache

set :scm, :git
set :repository, "github.com/pierrecoetzee/pierretest.git"
set :scm_passphrase, ""
set :branch, "master"
set :user, "root"
set :use_sudo, false
set :ssh_options, {:forward_agent => true}

set :deploy_to, "/var/www/html/pierretest"
role :web, "46.236.25.8"                          # Your HTTP server, Apache/etc
role :app, "46.236.25.8"                          # This may be the same as your `Web` server
role :db,  "46.236.25.8", :primary => true        # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:

after "deploy:restart", "deploy:cleanup"

set :rails_env, "test"

namespace :deploy do

    task :start do ; end
    task :stop do ; end
    task :restart, :roles => :app, :except => { :no_release => true } do

      run  "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
      run  " memcached -u nobody & "
      run  " ps -e | grep memcache | grep -v grep "
      puts "memcache up and running ... "
      run  " chmod 777 -R /var/www/html/pierretest/releases/ "
      puts "Run all the deployment tasks - more as time goes on"
    end
end