source 'https://rubygems.org'

gem 'rails', '~> 3.2.12'

gem 'sqlite3', :group => [:test, :development]
gem 'mysql2',  :group => [:production, :staging]

gem 'carrierwave'
gem 'jquery-rails'
gem 'json'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'turbo-sprockets-rails3'
  gem 'twitter-bootstrap-rails'
  gem 'uglifier'
end

group :production, :staging do
  gem 'therubyracer'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'thin'
end

group :test do
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'shoulda-matchers'
end
