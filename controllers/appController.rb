$:.unshift(File.expand_path('../../lib', __FILE__))

require 'sinatra/base'
require 'sinatra/flash'
require './sinatra/auth'
require 'erb'
require 'pony'
require 'v8'
require 'coffee-script'
require 'asset-handler'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash
  register Sinatra::Auth
  
  helpers ApplicationHelpers
      
  configure do
    enable :sessions
    set :username, 'frank'
    set :password, 'sinatra'
    set :root, File.expand_path('../../',__FILE__)
  end

  configure :development do
    set :email_address => 'smtp.gmail.com',
      :email_user_name => 'daz',
      :email_password => 'secret',
      :email_domain => 'localhost.localdomain'
  end

  configure :production do
    set :email_address => 'smtp.sendgrid.net',
      :email_user_name => ENV['SENDGRID_USERNAME'],
      :email_password => ENV['SENDGRID_PASSWORD'],
      :email_domain => 'heroku.com'
  end
  
  # Database configuration
  configure :development do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  end
  
  configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
  end

end
