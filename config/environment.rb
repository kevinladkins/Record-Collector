ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

#Sets envrionment constant pointing to absolute path of app
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

require 'dotenv'
Dotenv.load
require_all 'app'
require 'pry'
