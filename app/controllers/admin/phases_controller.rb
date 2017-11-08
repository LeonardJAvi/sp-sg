module Admin
  # PhasesController
  class PhasesController < AdminController
    before_action :set_phase, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    #person
    before_action :select_project

    def select_project
       @projects = Project.all
    end

    # GET /phases
    def index
      @q = Phase.ransack(params[:q])
      phases = @q.result(distinct: true)
      @objects = phases.page(@current_page)
      @total = phases.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to phases_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /phases/1
    def show
    end

    def view_data
      @phase = phase.find(params[:phase_id])
    end

    # GET /phases/new
    def new
      @phase = Phase.new
    end

    # GET /phases/1/edit
    def edit
    end

    # POST /phases
    def create
      @phase = Phase.new(phase_params)

      if @phase.save
        redirect(@phase, params)
      else
        render :new
      end
    end

    # PATCH/PUT /phases/1
    def update
      if @phase.update(phase_params)
        redirect(@phase, params)
      else
        render :edit
      end
    end

    def clone
      @phase = Phase.clone_record params[:phase_id]

      if @phase.save
        redirect_to admin_phases_path
      else
        render :new
      end
    end

    # DELETE /phases/1
    def destroy
      @phase.destroy
      redirect_to admin_phases_path, notice: actions_messages(@phase)
    end

    def destroy_multiple
      Phase.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_phases_path(page: @current_page, search: @query),
        notice: actions_messages(Phase.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_phase
      @phase = Phase.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def phase_params
      params.require(:phase).permit(:name, :description, :project_id)
    end

    def show_history
      get_history(Phase)
    end
  end
end
