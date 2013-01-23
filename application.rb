# require 'compass'
require 'sinatra/base'
require 'sinatra/assetpack'
require "sinatra/activerecord"
require './screening'
require 'pry'
require 'slim'
require 'json'

class Audio < Sinatra::Base

  register Sinatra::AssetPack
  register Sinatra::ActiveRecordExtension
  dbfile = File.expand_path('../screen.sqlite3', __FILE__)

  # set :database, "sqlite3:///#{dbfile}"
  set :database, {adapter: "postgresql", database: "dacj6mbjmmajvd", :host => "ec2-54-243-180-196.compute-1.amazonaws.com", :username => "furdplkjqaxcpy",:password => "ZTiqdWdS4axhAMlusal2k35Le4", port: 5432}
  set :app_file, __FILE__
  set :root, File.dirname(__FILE__)
  set :views, "views"
  set :public_folder, 'static'


  assets do
    serve '/js',     from: 'assets/js'        # Optional
    serve '/css',    from: 'assets/css'       # Optional
    serve '/images', from: 'assets/img'    # Optional

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    js :app,  [
      '/js/*.js'
    ]

    css :main, [
      '/css/*.css'
    ]

    css :forms, ['/css/forms/*.css']

    prebuild true
  end


  get '/' do
    @screenings = Screening.all
    slim :index
  end

  get '/entries' do
    content_type :json
    Screening.entries
  end

  post '/register' do
    para = JSON.parse params.keys.first
    pk = para.reject{|k,v| k == :id}
    @screening = Screening.create(pk)
    content_type :json
    {id: @screening.id.to_s, status: "true"}.to_json
  end
end
