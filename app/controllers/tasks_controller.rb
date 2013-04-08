class TasksController < ApplicationController

	attr_accessor :completed
	before_filter :find_list
	respond_to :html, :xml, :js

	def create
		
		@task = @list.tasks.new(params[:task])
		if @task.save
			flash[:notice] = "Task created"
			redirect_to list_url(@list)
		else
			flash[:error] = "Could not add task at this time! Make sure that field is not empty."
			redirect_to list_url(@list)
		end
	end


	def edit
		@task = @list.tasks.find(params[:id])
	end

	def update
		@task = @list.tasks.find(params[:id])
		if @task.update_attributes(params[:task])
			flash[:notice] = "Task updated."
			redirect_to list_url(@list)
		else
			flash[:error] = "Could not update task! Make sure that field is not empty."
			redirect_to edit_task_path(@list,@task)
		end
	end

	def destroy
		@task = @list.tasks.find(params[:id])
		if @task.destroy
			flash[:notice] = "Task deleted!"
			redirect_to list_url(@list)
		else
			flash[:error] = "Could not delete task. Have you done everything?"
			redirect_to list_url(@list)
		end
	end



	def complete
		@task = @list.tasks.find(params[:id])
		@task.completed = true
		@task.save
		redirect_to list_url(@list)
	end

	private

	def find_list
		@list = List.find(params[:list_id])
	end
end
