class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action:authenticate_user!

  # GET /tasks or /tasks.json
  def index
    @tasks_today = Task.where(date: Date.today).where(user: current_user.id).order("completion ASC").order("date ASC").order("category_id ASC")
    @tasks_future = Task.where("date > ?", Date.today).where(user: current_user.id).order("completion ASC").order("date ASC").order("category_id ASC")
    @categories = Category
    @tasks = Task.all.order("completion ASC").order("date ASC").order("category_id ASC")
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @categories = Category
    @tasks_today = Task.where(date: Date.today).where(user: current_user.id).order("completion ASC").order("date ASC").order("category_id ASC")
    @tasks_future = Task.where("date > ?", Date.today).where(user: current_user.id).order("completion ASC").order("date ASC").order("category_id ASC")
    @tasks = Task.all.order("completion ASC").order("date ASC").order("category_id ASC")
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @categories = Category.all.where(user: current_user.id).collect { |m| [m.title, m.id] }
  end

  # GET /tasks/1/edit
  def edit
    @categories = Category.all.where(user: current_user.id).collect { |m| [m.title, m.id] }
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.where(user: current_user.id).new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:id, :title, :body, :completion, :user, :category_id, :date)
    end
end