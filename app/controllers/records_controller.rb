#require_relative '../../config/environment'
#require_relative './application_controller.rb'
#require_relative '../models/record.rb'


class RecordsController < ApplicationController


  get '/records' do
    erb :'records/index'
  end


  get '/records/new' do
    erb :'records/new'
  end

  post '/records/new' do
    record = Record.find_or_create_by(params[:record])
    find_or_create(params, record)
    record.save
    redirect "/records/#{record.slug}"
  end

  get '/records/:slug' do
    @record = find_by_slug(params[:slug])
    binding.pry
    erb :'records/show'
  end

  get '/records/:slug/edit' do
    @record = find_by_slug(params[:slug])
    binding.pry
    erb :'records/edit'
  end

  post '/records/:slug/edit' do
    record = Record.find_by_slug(params[:slug])
    record.update(params[:record])
    binding.pry
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
