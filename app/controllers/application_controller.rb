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

    def logged_in?
      !!session[:engineer_id]
    end 

    def current_user 
      @current_user ||= Engineer.find_by(id: session[:engineer_id])
    end 

  end 

end