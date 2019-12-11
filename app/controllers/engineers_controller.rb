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
	                redirect to "/failure"
	            end
	        end
	    end

	    get '/failure' do
	        erb :'/engineers/failure'
	    end

  get '/login' do
	        erb :'/engineers/login'
	    end


	    post '/login' do
	        engineer = Engineer.find_by(username: params[:username])
	        if engineer && engineer.authenticate(params[:username])
	          session[:user_id] = engineer.id
	          redirect '/projects'
	        else
	          redirect '/failure'
	        end
	      end

	    get "/logout" do
	        session.clear
	        redirect "/"
	    end
	end 

	    