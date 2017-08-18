require_relative '../../config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  @@artists, @@record_user, @@labels, @@records = Artist.all, RecordUser.all, Label.all, Record.all

  not_found do
    if !!logged_in?
      redirect "/users/#{current_user.slug}"
    else
      redirect "/"
    end
  end


  get '/' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
    erb :index
    end
  end


  get '/error' do
    flash.now[:message] = "<h1 style='color: red;'>You must be logged in to do that.</h1>"
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def validate_user
      verify_login
      if current_user.slug != params[:slug]
        redirect "/users/#{current_user.slug}"
      end
    end

    def verify_login
      if !logged_in?
        redirect '/error'
      end
    end

  end

end
