class ProjectsController < ApplicationController

	    get "/projects" do
	        @projects = Project.all
	        erb :"projects/index"
	     end
	    
	      get "/projects/new" do
	        if(session[:engineer_id])
	          @current_user = Engineer.find(session[:engineer_id])
	        else
	          redirect '/failure'
	        end
	    
	        
	       @engineers = Engineer.all
	        erb :"projects/new"
	      end
	    
	      post "/projects" do 
	        engineer = Engineer.find_by(id: params[:engineer_id])
	        project = engineer.projects.build(params)
	        if project.save
	            redirect "/portofolio"
	        else
	            redirect "projects/new"
	        end
	      end
	    
	      get '/projects/:id' do
	        if(!session[:engineer_id])
	          redirect '/failure'
	        else 
	          @project = Project.find_by(id: params[:id])
	          if @project
	            erb :"projects/show"
	          else
	            redirect "/projects"
	          end
	        end
	      end
	    
	      get "/projects/:id/edit" do
	        @project = Project.find_by(id: params[:id])
	        if(!!session[:engineer_id])
	          erb :'projects/edit'
	        else
	          redirect '/failure'
	        end
	      end
	    
	      patch "/projects/:id" do
	        @project = Project.find_by(id: params[:id])
	        if @project.update(name: params[:name], content: params[:content], functionality: params[:functionality])
	            redirect "/projects/#{@project.id}"
	        else
	            redirect "/projects/#{@project.id}/edit"
	        end
	      end
	    
	      delete "/projects/:id" do
	        @project = Project.find_by(id: params[:id])
	        @project.delete
	        redirect "/portofolio"
	     end
	   end
