ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'


desc 'sets up connection to environment'
task :environment do
  require_relative './config/environment'
end

desc 'opens a Pry console'
task :console => :environment do
  Pry.start
end
