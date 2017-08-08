
require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

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
    flash[:message] = "#{record.name} has been added to your collection."
    redirect "/users/#{current_user.slug}"
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
