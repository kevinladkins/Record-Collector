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
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
    erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    else
      flash[:message] = "Incorrect username or password."
      redirect '/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
    erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:name] == "" || params[:email] == ""
      flash[:message] = "Please complete all fields."
      redirect '/signup'
    elsif User.find_by(username: params[:username], email: params[:email])
      redirect '/login'
    else
    user = User.create(params)
    session[:user_id] = user.id
    redirect "users/#{user.slug}"
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

  def verify_user
    if !logged_in?
      redirect '/'
    elsif
      current_user.slug != params[:slug]
      redirect "/users/#{current_user.slug}"
    end
  end

end
