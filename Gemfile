# frozen_string_literal: true
source "https://rubygems.org"
ruby '2.3.0'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'rack-flash3'
gem 'require_all'
gem 'sqlite3', :group => :development
gem 'thin'
gem 'shotgun'
gem 'pry', :group => :development
gem 'pg'
gem 'bcrypt'
gem 'tux', :group => :development
gem 'dotenv'
gem 'aws-sdk'


group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
