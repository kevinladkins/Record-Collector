
require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    else
      flash.now[:message] = "<h1 style='color: red;'>Incorrect username or password.</h1>"
      erb :index
    end
  end


  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:name] == "" || params[:email] == ""
      flash.now[:message] = "<h1 style='color: red;'>Please complete all fields.</h1>"
      erb :index
    elsif User.find_by(username: params[:username], email: params[:email])
      flash.now[:message] = "<h1 style='color: red;'>User account found. Please log in.</h1>"
      erb :index
    else
    user = User.create(params)
    session[:user_id] = user.id
    redirect "users/#{user.slug}"
    end
  end

  get '/users/:slug' do
    validate_user
    @user = current_user
    erb :'users/index'
  end


  post '/users/:slug/new' do
    validate_user
    record = Record.find(params[:record_id])
    current_user.records << record
    current_user.save
  end

  post '/users/:slug/delete' do
    validate_user
    record = RecordUser.find_by(user_id: current_user.id, record_id: params[:record_id])
    record.destroy
  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/'
    end
  end

end
