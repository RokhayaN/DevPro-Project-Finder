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

	    def current_user
	      @current_user ||= Engineer.find_by_id(session[:engineer_id]) if !!session[:engineer_id]
	    end
	    
	    def logged_in?
	      !!current_user
	    end

	    def valid_signup?
	      params[:username] != "" && params[:email] != "" && params[:password] != "" && params[:first_name] != ""
	    end

	    def not_valid_username
	      Engineer.all.find_by(username: params[:username])
	    end

	    def not_valid_email
	      Engineer.all.find_by(email: params[:email])
	    end
	  end
	end
