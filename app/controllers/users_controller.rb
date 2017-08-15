
require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

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


  


end
