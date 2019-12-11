class ProjectsController < ApplicationController
  
	    get'/projects'do
	       if logged_in?
	         @projects = Project.all.order(:name)
	         erb :'/projects/index'
	       else
	         redirect '/login'
	       end
	    end

	    get '/projects/new' do
	       erb :'/projects/new'
	    end
	     
post '/projects' do 
	       # binding.pry
	       if  params[:name] == "" || params[:content] == ""  || params[:funtionality] == "" 	          
                  redirect '/projects/new'        
	       end
	        engineer = current_user.engineers.build(name: params[:name],content: params[:content], functionality: params[:functionality])
	        if engineer.save
	            redirect '/projects'            
	        else
	            redirect '/projects/new'  
	        end         
	    end 

	     get '/projects/portofolio' do
	        if logged_in?
	            @projects=current_user.projects.order(:name)
	            erb :'/projects/portofolio'
	        else
	            redirect '/login'
	        end      
	    end

 get '/projects/:id' do 
	        if logged_in?
	            engineer = current_user
	            @engineer = engineer.projects.find_by(id: params[:id])
	            if @engineer 
	                erb :'projects/show'
	            else  
	                redirect '/projects'
	            end 
	        else 
	            redirect "/login"
	        end 
	    end 
 get '/projects/:id/edit' do 
	        if current_user
	            @engineer = current_user.projects.find_by(id: params[:id])
	            erb :"projects/edit"
	        else
	            redirect "/login"
	        end 
	    end


	    patch '/projects/:id' do 
	        @engineer = current_user
	        @projects = @engineer.projects.find_by(id: params[:id])
	        if !@engineer
	            redirect '/login'
	        else
	            @projects.update(name: params[:name],content: params[:content], functionality: params[:functionality])
	            redirect "/projects/#{@projects.id}"
	        end
	    end 


	    delete '/projects/:id' do 
	        if !logged_in?
	            redirect '/'
	        else @project= current_user.projects.find_by(id: params[:id])
	            @project.destroy
	            redirect '/projects'
	        end 
	    end 


	end

	   
	    


	    