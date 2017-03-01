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

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    else
      redirect '/error'
    end
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:name] == "" || params[:email] == ""
      redirect '/signup'
    elsif User.find_by(username: params[:username], email: params[:email])
      redirect '/login'
    else
    user = User.create(params)
    session[:user_id] = user.id
    redirect 'users/#{user.slug}'
    end
  end

  get '/error' do
    erb :error
  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/'
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
