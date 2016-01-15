set :application, 'Braim_Rails'
set :repo_url, 'git@github.com:JesusEduardo2028/Braim_Rails.git'

set :deploy_to, '/home/braim-pro/code/Braim_Rails'

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :rbenv_path , '$HOME/.rbenv'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end

    after 'deploy:publishing', 'deploy:restart'
    after 'deploy:finishing', 'deploy:cleanup'

  end

  after :publishing, 'deploy:restart'

end







