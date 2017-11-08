module Admin
  # TasksController
  class TasksController < AdminController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    before_action :select_phase

    def select_phase
       @projects = Project.all
    end

    # GET /tasks
    def index
      @q = Task.ransack(params[:q])
      tasks = @q.result(distinct: true)
      @objects = tasks.page(@current_page)
      @total = tasks.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to tasks_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /tasks/1
    def show
    end

    # GET /tasks/new
    def new
      @task = Task.new
    end

    # GET /tasks/1/edit
    def edit
    end

    # POST /tasks
    def create
      @task = Task.new(task_params)

      if @task.save
        redirect(@task, params)
      else
        render :new
      end
    end

    # PATCH/PUT /tasks/1
    def update
      if @task.update(task_params)
        redirect(@task, params)
      else
        render :edit
      end
    end

    def clone
      @task = Task.clone_record params[:task_id]

      if @task.save
        redirect_to admin_tasks_path
      else
        render :new
      end
    end



    # DELETE /tasks/1
    def destroy
      @task.destroy
      redirect_to admin_tasks_path, notice: actions_messages(@task)
    end

    def destroy_multiple
      Task.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_tasks_path(page: @current_page, search: @query),
        notice: actions_messages(Task.new)
      )
    end

    #Peticiones AJAX
    def options
       @item = []
       # @phases = Project.find(params[:project_id]).phases
       @phases = Phase.where(project_id: params[:project_id])
       @total = 0
       @unassigned = 0
       @assigned = 0
       @phases.each do |phase|
          @total = @phases.size
          if phase.task == nil
            @item << phase
            @unassigned = @item.size
          end
      end
      @assigned = @total-@unassigned
    end   

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:price_bolivar, :price_dolar, :cost_bolivar, :cost_dolar, :number_hours, :phase_id)
    end

    def show_history
      get_history(Task)
    end
  end
end



