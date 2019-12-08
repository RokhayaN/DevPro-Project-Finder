require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Hakuna Matata"
  end

  get "/" do
    erb :homepage 
  end
  helpers do 
    def current_user=Engineer.find_by_id(session[:Engineer_id] 
    
    
    
    
    
    