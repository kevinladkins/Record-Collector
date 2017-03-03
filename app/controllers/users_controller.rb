#require_relative './application_controller.rb'
#require_relative './records_controller.rb'

require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/users/:slug' do
    if !logged_in?
      redirect '/'
    elsif
      current_user.slug != params[:slug]
      redirect "/users/#{current_user.slug}"
    else
    @user = current_user
    @mode = "Records"
    erb :'users/index'
    end
  end

  post '/users/:slug' do
    if !logged_in?
      redirect '/'
    elsif
      current_user.slug != params[:slug]
      redirect "/users/#{current_user.slug}"
    else
      @mode = params[:mode]
      @user = current_user
      erb :'users/index'
    end
  end

  post '/users/:slug/new' do
    if !logged_in?
      redirect '/'
    elsif
      current_user.slug != params[:slug]
      redirect "/users/#{current_user.slug}"
    else
      record = Record.find(params[:record_id])
      current_user.records << record
      current_user.save
      flash[:message] = "#{record.name} has been added to your collection."
      redirect "/users/#{current_user.slug}"
   end
  end

  post '/users/:slug/delete' do
    if !logged_in?
      redirect '/'
    elsif
      current_user.slug != params[:slug]
      redirect "/users/#{current_user.slug}"
    else
    record = RecordUser.find_by(user_id: current_user.id, record_id: params[:record_id])
    record.destroy
    redirect "/users/#{params[:slug]}"
   end
  end





end
