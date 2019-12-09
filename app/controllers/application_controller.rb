require_relative './config/environment'
require './app/models/engineer'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Hakuna Matata"
    
    get '/' do 
      erb:homepage
  
 get "/signup" do
	    erb :signup
	  end


	  post "/signup" do
	    if params[:username].empty?
	      redirect '/failure'
	    end
	    user = Engineer.new(:username => params[:username], :password => params[:password])
			if user.save
	      redirect "/login"
	    else
	      redirect "/failure"
	    end
	 end
end 
	  get "/portofolio"do
	    @engineer = Engineer.find(session[:engineer_id])
	    erb :portofolio
	  end

	  get "/login" do
	    erb :login
	  end


	  post "/login" do
	    user = Engineer.find_by(:username => params[:username])
	 
	    if user && user.authenticate(params[:password])
	      session[:engineer_id] = user.id
	      redirect "/account"
	    else
	      redirect "/failure"
	    end
	  end


	  get "/failure" do
	    erb :failure
	  end


	  get "/logout" do
	    session.clear
	    redirect "/"
	  end
	  
	  helpers do
	    def logged_in?
	      !!session[:engineer_id]
	    end


	 def current_user
	   Engineer.find(session[:engineer_id])
	 end
	end 
	
