require 'sinatra'
require 'sinatra/reloader' if settings.development?
require 'bundler/setup'
require 'slim'
require 'sass'
require './song'
require 'sinatra/flash'
require 'pony'
require './sinatra/auth'
require 'v8'
require 'coffee-script'

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  set :email_address => 'smtp.gmail.com',
      :email_user_name => 'sonnyparlin@gmail.com',
      :email_password => 'razorfromguard',
      :email_domain => 'localhost.localdomain'
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
  set :email_address => 'smtp.sendgrid.net',
      :email_user_name => ENV['SENDGRID_USERNAME'],
      :email_password => ENV['SENDGRID_PASSWORD'],
      :email_domain => 'heroku.com'
end

helpers do
  def css(*stylesheets)
    stylesheets.map do |style| 
      "<link href=\"/#{style}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end.join
  end
  
  def current?(path='/')
      (request.path==path || request.path==path+'/') ? "current" : nil
    end
    
  def set_title
    @title ||= "Songs By Sinatra"
  end
end

before do
  set_title
end

get('/styles.css'){ scss :styles }
get('/javascripts/application.js'){ coffee :application }

get '/' do
  slim :home
end

get '/about' do
  slim :about
end

get '/contact' do
  slim :contact
end

not_found do
  slim :not_found
end

get '/fake-error' do
  status 500
  "ERROR: 500 - but There’s nothing wrong, really :P"
end

get '/environment' do
  if settings.development?
    "development"
  elsif settings.production?
    "production"
  elsif settings.test?
    "test"
  else
    "Who knows what environment you're in!"
  end
end

post '/contact' do
  send_message
  flash[:notice] = "Thank you for your message. We'll be in touch soon."
  redirect to('/')
end

def send_message
  Pony.mail(
    :from => params[:name] + "<" + params[:email] + ">",
    :to => 'sonnyparlin@gmail.com',
    :subject => params[:name] + " has contacted you",
    :body => params[:message],
    :port => '587',
    :via => :smtp,
    :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => 'sonnyparlin',
      :password             => 'razorfromguard',
      :authentication       => :plain,
      :domain               => 'localhost.localdomain'
    })
end