#require_relative './application_controller.rb'
#require_relative './records_controller.rb'

class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @record = Record.find(1)
    erb :'users/index'
  end

end
