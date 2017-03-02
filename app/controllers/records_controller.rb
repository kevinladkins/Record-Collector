require_relative './application_controller.rb'
require_relative './users_controller.rb'

class RecordsController < ApplicationController

  get '/' do
    erb :'records/index'
  end

  get '/records/:slug' do
    @record = Record.find_by_slug(params[:slug])
    erb :'records/show'
  end

  get 'records/new' do
    erb :'records/new'
  end

  post 'records/new' do
    record = Record.create(params)
    current_user.records << record
    redirect "/records/#{record.slug}"
  end


end
