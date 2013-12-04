$:.unshift(File.expand_path('../../lib', __FILE__))

require 'sinatra/base'
require 'erb'
require 'pony'
require 'v8'
require 'coffee-script'
require 'asset-handler'
require "digest/sha1"
require 'rack-flash'
require 'sinatra-authentication'
require 'haml'

class ApplicationController < Sinatra::Base
  register Sinatra::SinatraAuthentication 
  use Rack::Session::Cookie, :secret => 'All good things comes to those who waits.'
  use Rack::Flash
  
  helpers ApplicationHelpers
      
  configure do
    set :root, File.expand_path('../../',__FILE__)
    set :erb, :layout_engine => :haml # Needed by sinatra-authentication, they only recognize a haml layout
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
