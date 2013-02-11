require 'bundler/capistrano'
#require 'delayed/recipes'
require 'rvm/capistrano'

set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"").gsub(/-p\d+/,"")
set :keep_releases, 11

set :use_sudo, false
set :application, 'Dossier'

set :deploy_to, "/var/www/apps/#{application}"

set :scm, :git
set :repository, 'git@github.com:ASCTech/Dossier.git'
set :branch, 'master'
set :branch, $1 if `git branch` =~ /\* (\S+)\s/m
set :deploy_via, :remote_cache

set :user, 'deploy'
set :ssh_options, { :forward_agent => true }

task :staging do
  set :rails_env, 'staging'
  role :app, "apps-s.asc.ohio-state.edu"
  role :web, "apps-s.asc.ohio-state.edu"
  role :db,  "apps-s.asc.ohio-state.edu", :primary => true
end

task :production do
  set :rails_env, 'production'
  set :branch, 'master'

  role :app, "appservices.asc.ohio-state.edu"
  role :web, "appservices.asc.ohio-state.edu"
  role :db,  "appservices.asc.ohio-state.edu", :primary => true
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  desc "Restarting passenger with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc "Places seed data in database"
  task :seed, :roles => :app do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=#{rails_env} db:seed"
  end
end

before "deploy:assets:precompile" do
  run ["ln -nfs #{shared_path}/config/settings.yml #{release_path}/config/settings.yml",
       "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml",
       "ln -nfs #{shared_path}/config/opic.yml #{release_path}/config/opic.yml",
       "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml",
       "ln -nfs #{shared_path}/config/initializers/egg.rb #{release_path}/config/initializers/egg.rb",
       "ln -fs #{shared_path}/uploads #{release_path}/uploads"
  ].join(" && ")
end

before "deploy:update", "rvm:create_gemset"

#after "deploy", "delayed_job:restart", "deploy:cleanup"
after "deploy", "deploy:cleanup"
