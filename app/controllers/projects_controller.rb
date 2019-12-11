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
	            @projects=Project.find_by_id(params[:id])
	            if current_user.projects.include?(@project)
	                @own_project=@project
	            end
	            erb :'/projects/show'
	        else
	            redirect '/login'
	        end
	    end


	    get '/projects/:id/edit' do
	        if logged_in?
	            @project=current_user.projects.find_by_id(params[:id])
	            if @project
	                erb :'/projects/edit'
	            else
	                redirect '/projects/error'
	            end
	        else
	            redirect '/login'
	        end
	    end


	    patch '/projects/:id' do
	        if logged_in?
	            if params[:name] != "" && params[:content] != ""
	                @project=Project.find_by_id(params[:id])
	                @project.update(name: params[:name],content: params[:content],functionality: params[:functionality])
	                redirect '/projects/#{@project.id}' 
	            else
	                redirect '/projects/#{params[:id]}/edit'
	            end
	        else
	            redirect'/login'
	        end
	    end


	    get '/error' do
	        erb :'/projects/error'
	    end


	    delete '/projects/:id/delete' do
	        if logged_in?
	            @project= current_user.projects.find_by_id(params[:id])
	            if @project
	                @project.delete
	               redirect '/projects'
	            else
	               redirect '/error'
           end
	        else
	           redirect '/login'
	        end
	    end 


	end
