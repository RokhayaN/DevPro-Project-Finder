class ProjectsController < ApplicationController
  
	    get '/projects' do
	        check_log_in_status
	        @projects = current_user.projects.order(:name)
	        erb :'/projects/index'
	    end


	    get '/projects/new' do
	        check_log_in_status
	        erb :'/projects/new'
	    end


	    post'/projects' do
	        check_log_in_status
	        if params[:name]!= "" && params[:content] != ""
	        	@project=current_user.projects.build(params)
	            if @project.save
	                redirect"/projects/#{@project.id}"
				end        
	        end 
	        redirect'/projects/new'
	     end

	    get '/projects/:id' do
	        check_log_in_status
	        @project=current_user.projects.find_by_id(params[:id])
	        if @project    
	            erb :'/projects/show'
	        else
	            redirect '/projects'
			end
		end


	    get '/projects/:id/edit' do
	        check_log_in_status
	        @project=current_user.projects.find_by_id(params[:id])
	        if @project
	            erb :'/projects/edit'
	        else
	            redirect'/error'
			end 
			
	    end


	    patch '/projects/:id' do
	        check_log_in_status
	        if params[:name] != "" && params[:content] != ""
	            @project=current_user.projects.find_by_id(params[:id])
	            if @project
	                @project.update(name: params[:name],content: params[:content],functionality: params[:functionality])
	                redirect"/projects/#{@project.id}"
	            else
	                redirect"/projects"
	            end 
	        else
	            redirect"/projects/#{params[:id]}/edit" 
	        end
			
	    end


	    get '/error' do
	        erb :'/students/error'
	    end


		delete '/projects/:id' do
			check_log_in_status
	        @project = current_user.projects.find_by_id(params[:id])
	        if @project
	           @project.delete
	           redirect'/projects'
	        else
	           redirect'/error'
	    	end
  		end
  
  private

  def check_log_in_status 
	if !logged_in? 
		redirect '/login'
	end 	
  end 
end 



