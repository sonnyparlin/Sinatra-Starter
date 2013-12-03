require 'sinatra/base'

class Website < ApplicationController
  use AssetHandler
  register Sinatra::Auth
  register Sinatra::Flash

  before do
    set_title
  end
  
  def set_title
    @title ||= "Songs By Sinatra"
  end
  
  def send_message
    Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => 'daz',
      :subject => params[:name] + " has contacted you",
      :body => params[:message],
      :port => '587',
      :via => :smtp,
      :via_options => { 
        :address              => 'smtp.gmail.com', 
        :port                 => '587', 
        :enable_starttls_auto => true, 
        :user_name            => 'daz', 
        :password             => 'secret', 
        :authentication       => :plain, 
        :domain               => 'localhost.localdomain'
      }
    )
  end

  get '/' do
    erb :home
  end
  
  get '/about' do
    @title = "All About This Website"
    erb :about
  end
  
  get '/contact' do
    erb :contact
  end
  
  not_found do
    erb :not_found
  end
  
  post '/contact' do
    send_message
    flash[:notice] = "Thank you for your message. We'll be in touch soon."
    redirect to('/')
  end
end
