source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'carrierwave'
gem 'devise_token_auth', '~> 1.1', '>= 1.1.4'
gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'
gem 'fog'
gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search'
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'stripe'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-dotenv', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'listen', '~> 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
