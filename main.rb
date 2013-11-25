require 'sinatra'
require 'sinatra/reloader' if settings.development?
require 'slim'
require 'sass'
require './song'

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

get('/styles.css'){ scss :styles }

get '/' do
  @title = "Sinatra the great"
  slim :home
end

get '/about' do
  @title = "Sinatra the greatest"
  slim :about
end

get '/contact' do
  @title = "Sorry, he's dead"
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

get '/login' do
  slim :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end