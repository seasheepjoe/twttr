namespace :install do
    server 'carlos.place', roles: [:app]
    desc "Installing the web app"
    task :installing do
      on roles(:app) do |host|
        execute 'cd /var/www/html/twttr/current && composer install && npm install && chown -R www-data:www-data /var/www/html/twttr'
      end
    end
  end