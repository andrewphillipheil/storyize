default_run_options[:pty] = true
set :application, "storyize"
set :deploy_to, "/var/www/#{application}"

set :repository, "git@github.com:andrewphillipheil/storyize.git"

set :scm, :git
set :user, "w3villa"

set :branch, "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "50.112.59.44" # Your HTTP server, Apache/etc
role :app, "50.112.59.44" # This may be the same as your `Web` server
role :db, "50.112.59.44", :primary => true # This is where Rails migrations will run
#role :db, "your slave db-server here"
set :ssh_options, { :forward_agent => true }
ssh_options[:keys] = [File.join(ENV["HOME"], "w3villa")]

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; 
  end
end

desc "Restarting mod_rails with restart.txt"
task :restart, :roles => :app, :except => { :no_release => true } do
  run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
end

task :after_symlink, :roles => :app do
  run "cp #{shared_path}/config/database.yml #{current_path}/config/database.yml"
end

desc "Deploy with migrations"
task :long do
  transaction do
    update_code
    web.disable
    symlink
    migrate
  end

  restart
  web.enable
  cleanup
end

desc "Run cleanup after long_deploy"
  task :after_deploy do
    cleanup
  end
end