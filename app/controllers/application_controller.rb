require_relative '../../config/environment'
#require_relative './records_controller.rb'
#require_relative './users_controller.rb'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
    erb :index
    end
  end


  get '/error' do
    erb :error
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  def verify_user
    if !logged_in?
      redirect '/'
    elsif
      current_user.slug != params[:slug]
      redirect "/users/#{current_user.slug}"
    end
  end

end
