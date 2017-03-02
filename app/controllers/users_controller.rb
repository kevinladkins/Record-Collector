#require_relative './application_controller.rb'
#require_relative './records_controller.rb'

class UsersController < ApplicationController

  get '/users/:slug' do
    if !logged_in?
      redirect '/login'
    else
    @user = User.find_by_slug(params[:slug])
    erb :'users/index'
    end
  end

  get '/users/:slug/records' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      erb :'users/show/by_record'
    end
  end

  get '/users/:slug/artists' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      erb :'users/show/by_artist'
    end
  end

  get '/users/:slug/labels' do
      erb :'users/show/by_label'
  end

  post '/users/:slug/delete' do
    record = RecordUser.find_by(user_id: current_user.id, record_id: params[:record_id])
    record.destroy
    redirect "/users/#{params[:slug]}"
  end





end
