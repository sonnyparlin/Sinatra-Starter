class AssetHandler < Sinatra::Base
  configure do
    set :root, File.expand_path('../../',__FILE__)
    set :views, settings.root + '/assets'
    enable :coffeescript
    set :jsdir, 'js'
  end
  
  get '/javascripts/*.js' do
    pass unless settings.coffeescript?
    last_modified File.mtime(settings.root+'/assets/'+settings.jsdir)
    cache_control :public, :must_revalidate
    coffee (settings.jsdir + '/' + params[:splat].first).to_sym
  end
  
end