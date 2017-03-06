#require_relative '../../config/environment'
#require_relative './application_controller.rb'
#require_relative '../models/record.rb'

require 'rack-flash'

class RecordsController < ApplicationController
  enable :sessions
  set :session_secret, "secret"



use Rack::Flash

  get '/records' do
    verify_login
    @mode = "Records"
    @records = @@records
    @labels = @@labels
    @artists = @@artists
    binding.pry
    erb :'records/index'
  end

  post '/records' do
    verify_login
    @records = @@records
    @labels = @@labels
    @artists = @@artists
    @mode = params[:mode]
    erb :'records/index'
  end

  get '/records/new' do
    verify_login
    @labels = @@labels
    @artists = @@artists
    erb :'records/new'
  end

  post '/records/new' do
    verify_login
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
    verify_login
    @record = find_by_slug(params[:slug])
    erb :'records/show'
  end

  get '/records/:slug/edit' do
    verify_login
    if !in_collection?(params[:slug])
      flash[:message] = "Record must be in your collection to edit"
      redirect "/records/#{params[:slug]}"
    else
    @record = find_by_slug(params[:slug])
    @labels = @@labels
    @artists = @@artists
    erb :'records/edit'
    end
  end

  post '/records/:slug/edit' do
    verify_login
    record = Record.find_by_slug(params[:slug])
    record.update(params[:record])
    find_or_create(params, record)
    record.save
    redirect "/records/#{record.slug}"
  end

  helpers do

    def in_collection?(slug)
      current_user.records.include?(Record.find_by_slug(slug))
    end

    def find_by_slug(slug)
      Record.find_by_slug(slug)
    end

    def find_or_create(params, record)
      if params[:artist][:name] != ""
        record.artist_id = Artist.find_or_create_by(name: params[:artist][:name]).id
        current_user.save
        record.save
      end
      if params[:label][:name] != ""
        record.label_id = Label.find_or_create_by(name: params[:label][:name]).id
        record.save
      end
    end

  end


end
