require './config/environment'

class ApplicationController < Sinatra::Base
  configue do
    enable :sessions
    set :session_secret, "secret"
  end

end
