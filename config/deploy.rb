require "rvm/capistrano"
require 'bundler/setup'
require 'bundler/capistrano'

set :application, "sureaudios"
set :repository,  "git@github.com:dgtm/sureaudios.git"
set :scm, :git

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.33.10"                          # Your HTTP server, Apache/etc
role :app, "192.168.33.10"                          # This may be the same as your `Web` server
role :db,  "192.168.33.10", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


set :user, "deploy"
set :password, "kathmandu09"

set :use_sudo, false

set :rvm_ruby_string, '1.9.3-p374'
set :rvm_type, :system

ssh_options[:forward_agent] = true
# ssh_options[:port] = 2020
default_run_options[:pty] = true

# change the branch by using -s branch=branchname on the command line
set :branch, fetch(:branch, 'master')

set :deploy_via, :remote_cache
set :deploy_to, "/home/deploy/sureaudios"

namespace :deploy do
  desc "Start Application"
    task :upgrade, :roles => :web do
    if remote_file_exists?("#{current_path}/tmp/pids/unicorn.pid")
      # we don't want to fail if we can't find the pid so we append '; true'
      run "kill -USR2 `cat #{current_path}/tmp/pids/unicorn.pid`; true"
    else
      start
    end
  end
  
  task :restart, :roles => :web do
    # we don't want to fail if we can't find the pid so we append '; true'
          run "kill -USR2 `cat #{current_path}/tmp/pids/unicorn.pid`; true"

    # stop && start
  end

  task :stop, :roles => :web do
    # we don't want to fail if we can't find the pid so we append '; true'
    run "kill -QUIT `cat #{current_path}/tmp/pids/unicorn.pid`; true"
  end

  task :start, :roles => :web do
    run "cd #{current_path}; bundle exec unicorn -c config/unicorn.rb -D"
  end
end