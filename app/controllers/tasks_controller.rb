class TasksController < ApplicationController

  def new
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new
  end

  def create
    @task_list = TaskList.find(params[:task_list_id])
    task_params = params.require(:task).permit(:description, :due_date)
    @task = @task_list.tasks.new(task_params)

    @task.completed = params[:task][:completed]

    if @task.save
      redirect_to root_path, notice: "Task was created successfully!"
    else
      render :new
    end
  end

end