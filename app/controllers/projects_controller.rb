class ProjectsController < ApplicationController
  
	    get '/projects' do
	        if logged_in?
	          
	            @projects = current_user.projects.order(:name)
	            erb :'/projects/index'
	        else
	            redirect'/login'
	        end
	    end


	    get '/projects/new' do
	        if logged_in?
	            erb :'/projects/new'
	        else
	            redirect'/login'
	        end
	    end


	    post'/projects' do
	        if logged_in?
	             if params[:name]!= "" && params[:content] != ""
	                 @project=current_user.projects.build(params)
	                 if @project.save
	                   redirect"/projects/#{@project.id}"
	                 else 
	                   redirect '/projects/new'
	                 end 
	             else
	                 redirect'/projects/new'
	             end
	         else
	             redirect'/login'
	         end
	     end

	    get '/projects/:id' do
	        if logged_in?
	            @project=current_user.projects.find_by_id(params[:id])
	            
	            if @project    
	             erb :'/projects/show'
	            else
	              redirect '/projects'
	            end
	        else
	            redirect'/login'
	        end
	    end


	    get '/projects/:id/edit' do
	        if logged_in?
	            @project=current_user.projects.find_by_id(params[:id])
	            if @project
	                erb :'/projects/edit'
	            else
	                redirect'/error'
	            end
	        else
	            redirect'/login'
	        end
	    end


	    patch '/projects/:id' do
	        if logged_in?
	            if params[:name] != "" && params[:content] != ""
	                @project=current_user.projects.find_by_id(params[:id])
	                if @project
	                  @project.update(name: params[:name],content: params[:content],functionality: params[:functionality])
	                  redirect"/projects#{@project.id}"
	                else
	                  redirect"/projects"
	                end 
	            else
	                redirect"/projects/#{params[:id]}/edit" 
	            end
	        else
	            redirect'/login'
	        end
	    end


	    get '/error' do
	        erb :'/students/error'
	    end


	    delete '/projects/:id' do
	        if logged_in?
	            @project = current_user.projects.find_by_id(params[:id])
	            if @project
	                @project.delete
	                redirect'/projects'
	            else
	               redirect'/error'
	            end
	        else
	           redirect'login'
	        end
  end
end 

