# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.3'
gem 'rails', '5.1.6.1'

gem 'pg' # Using PostgreSQL as DB
gem 'puma'

gem 'haml-rails'
gem 'jbuilder'

group :assets do
  gem 'sass-rails'
  gem 'uglifier'
end

group :console do
  gem 'awesome_print'
end

group :development do
  gem 'guard-rspec', require: false
  gem 'listen'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
end
