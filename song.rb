require 'dm-core'
require 'dm-migrations'

class Song
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :lyrics, Text
  property :length, Integer
  property :released_on, Date
  
  def released_on=date
     super Date.strptime(date, '%m/%d/%Y')
   end
   
end

DataMapper.finalize

get '/songs' do
  @title = "List of Songs"
  @songs = Song.all
  slim :songs
end

get '/songs/new' do
  @song = Song.new
  slim :new_song
end

post '/songs' do
  song = Song.create(params[:song])
  redirect to("/songs/#{song.id}")
end

get '/songs/:id/edit' do
  halt(401,'Not Authorized') unless session[:admin] 
  @song = Song.get(params[:id])
  slim :edit_song
end

get '/songs/:id' do
  @song = Song.get(params[:id])
  slim :show_song
end

put '/songs/:id' do
  halt(401,'Not Authorized') unless session[:admin] 
  song = Song.get(params[:id])
  song.update(params[:song])
  redirect to("/songs/#{song.id}")
end

delete '/songs/:id' do
  halt(401,'Not Authorized') unless session[:admin] 
  Song.get(params[:id]).destroy
  redirect to('/songs')
end