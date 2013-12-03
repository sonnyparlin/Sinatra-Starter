class SongController < ApplicationController
  enable :method_override

  helpers SongHelpers

  before do
    set_title
  end
  
  def css(*stylesheets)
    stylesheets.map do |stylesheet| 
      "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end.join
  end
  
  def current?(path='/')
    (request.path==path || request.path==path+'/') ? "current" : nil
  end
  
  def set_title
    @title ||= "Songs By Sinatra"
  end
  
  get '/' do
    find_songs
    erb :songs
  end
  
  get '/new' do
    protected!
    @song = Song.new
    erb :new_song
  end
  
  get '/:id' do
    @song = find_song
    erb :show_song
  end
  
  get '/:id/edit' do
    protected!
    @song = find_song
    erb :edit_song
  end
  
  post '/' do
    protected!
    create_song
    if create_song
      flash[:notice] = "Song successfully added"
    end
    redirect to("/#{@song.id}")
  end
  
  put '/:id' do
    protected!
    song = find_song
    if song.update(params[:song])
      flash[:notice] = "Song successfully updated"
    end
    redirect to("/#{song.id}")
  end
  
  delete '/:id' do
    protected!
    if find_song.destroy
      flash[:notice] = "Song deleted"
    end
    redirect to('/')
  end
  
  post '/:id/like' do
    @song = find_song
    @song.likes = @song.likes.next
    @song.save
    redirect to("/#{@song.id}") unless request.xhr?
    erb :like, :layout => false
  end
end
