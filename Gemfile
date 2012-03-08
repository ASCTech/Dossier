source 'https://rubygems.org'

gem 'rails'

gem 'sqlite3', :group => [:test, :development]
gem 'mysql2',  :group => [:production]

gem 'carrierwave'
gem 'jquery-rails'
gem 'json'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'twitter-bootstrap-rails'
  gem 'uglifier'
end

group :development, :production do
  gem 'therubyracer'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  gem 'capistrano'
  gem 'thin'
end

group :test do
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'shoulda-matchers'
end
