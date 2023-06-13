# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7', '>= 6.1.7.2'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Authentication
gem 'jwt'

# API support
gem 'active_model_serializers', '~> 0.10.2'
gem 'pagy', '~> 6.0'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot', '~> 6.2', '>= 6.2.1'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'hotwire-livereload'
  gem 'rails-controller-testing'
  gem 'rails-erd'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rspec-request_describer'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'annotate'
  gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'rspec_junit_formatter', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
