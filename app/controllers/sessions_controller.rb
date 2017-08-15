require 'rack-flash'

class SessionsController < ApplicationController

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

  get '/logout' do
    binding.pry
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/'
    end
  end




end
