#require_relative '../../config/environment'
#require_relative './application_controller.rb'
#require_relative '../models/record.rb'

require 'rack-flash'

class RecordsController < ApplicationController

use Rack::Flash

  get '/records' do
    if !logged_in?
      redirect '/'
    else
    @mode = "Records"
    erb :'records/index'
    end
  end

  post '/records' do
    if !logged_in?
      redirect '/'
    else
      @mode = params[:mode]
      erb :'records/index'
    end
  end

  get '/records/new' do
    erb :'records/new'
  end

  post '/records/new' do
    if Record.find_by(name: params[:record][:name], artist_id: params[:record][:artist_id])
       record = Record.find_by(name: params[:record][:name], artist_id: params[:record][:artist_id])
       flash[:message] = "Is this the record you're looking for?"
    else
      record = Record.create(params[:record])
      find_or_create(params, record)
      record.save
      current_user.records << record
    end
    redirect "/records/#{record.slug}"
  end

  get '/records/:slug' do
    @record = find_by_slug(params[:slug])
    erb :'records/show'
  end

  get '/records/:slug/edit' do
    @record = find_by_slug(params[:slug])
    erb :'records/edit'
  end

  post '/records/:slug/edit' do
    record = Record.find_by_slug(params[:slug])
    record.update(params[:record])
    find_or_create(params, record)
    record.save
    redirect "/records/#{record.slug}"
  end

  helpers do
    def find_by_slug(slug)
      Record.find_by_slug(slug)
    end

    def find_or_create(params, record)
      if !params[:artist] == " "
        record.artist_id = Artist.find_or_create_by(name: params[:artist][:name]).id
        current_user.records << record
        current_user.save
        record.save
      end
      if !params[:label] == " "
        record.label_id = Label.find_or_create_by(name: params[:label][:name]).id
        record.save
      end
    end

  end


end
