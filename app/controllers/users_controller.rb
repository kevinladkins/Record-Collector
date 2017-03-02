#require_relative './application_controller.rb'
#require_relative './records_controller.rb'

class UsersController < ApplicationController

  get '/users/:slug' do
    if !logged_in?
      redirect '/login'
    else
    @user = User.find_by_slug(params[:slug])
    @mode = "Records"
    erb :'users/index'
    end

  end

  post '/users/:slug' do
    @mode = params[:mode]
    @user = current_user
    erb :'users/index'
  end


  post '/users/:slug/delete' do
    record = RecordUser.find_by(user_id: current_user.id, record_id: params[:record_id])
    record.destroy
    redirect "/users/#{params[:slug]}"
  end





end
