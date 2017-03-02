#require_relative './application_controller.rb'
#require_relative './records_controller.rb'

class UsersController < ApplicationController

  get '/users/:slug' do
    if !logged_in?
      redirect '/login'
    @user = User.find_by_slug(params[:slug])
    erb :'users/index'
  end

  get 'users/:slug/records' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      erb :'users/show/by_record.erb'
    end
  end

  get 'users/:slug/artists' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      erb :'users/show/by_artist.erb'
    end
  end

  get 'users/:slug/labels' do
      erb :'users/show/by_artist.erb'
  end





end
