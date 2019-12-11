class ProjectsController < ApplicationController
  
	    get '/projects' do
	        if logged_in?
	            @projects = Project.all.order(:name)
	            erb :'/projects/index'
	        else
	            redirect '/login'
	        end
	    end


	    get '/projects/new' do
	        if logged_in?
	            erb :'/projects/new'
	        else
	            redirect '/login'
	        end
	    end


	    post '/projects' do
	        if logged_in?
	             if params[:name]!= "" && params[:content] != ""
	                 @project=Project.new(params)
	                 @project.engineer=current_user
	                 @project.save
	                 redirect '/projects/#{@project.id}' 
	             else
	                 redirect '/projects/new'
	             end
	         else
	             redirect '/login'
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
	            @project=Project.find_by_id(params[:id])
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
	                redirect '/error'
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
	            redirect '/login'
	        end
	    end


	    get '/error' do
	        erb :'/students/error'
	    end


	    delete '/projects/:id/delete' do
	        if logged_in?
	            @project = current_user.projects.find_by_id(params[:id])
	            if @project
	                @project.delete
	                redirect '/projects'
	            else
	                redirect '/error'
	            end
	        else
	            redirect 'login'
	        end
   end
end 
