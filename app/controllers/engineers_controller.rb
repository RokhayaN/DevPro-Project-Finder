 class EngineersController < ApplicationController
   
	    get '/signup' do
	        if !logged_in?
	         erb :'/engineers/signup'
	       end
	    
	    post "/signup" do
	        if params[:username] == "" || params[:password] == "" || params[:email] == ""
	            redirect to "/signup"
	        else 
	            engineer = Engineer.create(:username => params[:username], :email => params[:email], :password => params[:password]
	            session[:engineer_id] = engineer.id
	            if logged_in?
	                redirect "/projects"
	            else
	                redirect to "/signup"
	            end
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


	    get '/failure' do
	        erb :'/engineers/failure'
	    end


	    get '/logout' do
	        if logged_in?
	            erb :'/engineers/logout'
	        else
	            redirect to "/"
	        end 
	    end


	    post '/logout' do
	        session.destroy
	        redirect "/"
	    end
end       

