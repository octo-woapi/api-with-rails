# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.0'
gem 'rails', '5.1.5'

gem 'pg' # Using PostgreSQL as DB
gem 'puma'

gem 'devise'

gem 'haml-rails'
gem 'jbuilder'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

group :production do
  gem 'rails_12factor'
end

group :console do
  gem 'awesome_print'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'teaspoon-jasmine'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
end