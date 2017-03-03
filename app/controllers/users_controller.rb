#require_relative './application_controller.rb'
#require_relative './records_controller.rb'

require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/users/:slug' do
    verify_user
    @user = current_user
    @mode = "Records"
    erb :'users/index'
  end

  post '/users/:slug' do
    verify_user
    @mode = params[:mode]
    @user = current_user
    erb :'users/index'
  end

  post '/users/:slug/new' do
    verify_user
    record = Record.find(params[:record_id])
    current_user.records << record
    current_user.save
    flash[:message] = "#{record.name} has been added to your collection."
    redirect "/users/#{current_user.slug}"
  end

  post '/users/:slug/delete' do
    verify_user
    record = RecordUser.find_by(user_id: current_user.id, record_id: params[:record_id])
    record.destroy
    redirect "/users/#{params[:slug]}"
  end





end
