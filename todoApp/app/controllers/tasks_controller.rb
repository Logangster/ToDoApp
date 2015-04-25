class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :markDone]

  #Used for marking status updates as done
  def markDone
    @task.status = "Done"
    @task.save
    redirect_to lists_path
  end

  # GET /tasks
  def index
    #no need to show the tasks index with the lists view in place
    redirect_to lists_path
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    #Get list and build a task based on the list
    @list = List.find(params[:list_id]);
    @task = @list.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    #Get list and build a task based on the list
    @list = List.find(params[:list_id]);
    @task = @list.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to list_task_path(@list, @task), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to list_task_path(@list, @task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @list = List.find(params[:list_id])
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :due, :status, :list)
    end
end
