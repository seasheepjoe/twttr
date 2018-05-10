namespace :save do
    server 'carlos.place', roles: [:app]
    desc "Saving profile pictures"
    task :copying do
      on roles(:app) do |host|
        execute 'cd /var/www/html/twttr/current && cp -r assets/pp/ /var/www/html/twttr/shared/assets/'
      end
    end
  end