 class EngineersController < ApplicationController

	      get '/signup' do
	        if !logged_in?
	            erb :'/engineers/signup'
	        else
	            redirect '/projects'
	        end
	    end


	    post '/signup' do
	        if valid_signup? && !not_valid_username && !not_valid_email
	            @engineer=Engineer.new(params) 
	            @engineer.save
	            session[:engineer_id]=@engineer.id
	            redirect '/projects'   
	        else  
	           redirect '/failure' 
	        end
	    end


	    get '/failure' do
	        erb :'/engineers/failure'
	    end


	    get '/login' do
	        if !logged_in?
	            erb :'/engineers/login'
	        else
	            redirect '/projects' 
	        end
	    end


	    post '/login' do
	        @engineer = Engineer.find_by(username: params[:username])
		    if @engineer && @engineer.authenticate(params[:password])
				session[:engineer_id] = @engineer.id
				redirect '/projects'
			else
				redirect '/failure'
	        end
	    end


	
	    get '/logout' do
	        if logged_in?
	            erb :'engineers/logout'
	        else
	            redirect to "/"
	        end 
	    end


	    post '/logout' do
	        session.destroy
	        redirect "/"
	    end


	end
