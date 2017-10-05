module Admin
  # StackStatesController
  class StackStatesController < AdminController
    before_action :set_stack_state, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /stack_states
    def index
      @q = StackState.ransack(params[:q])
      stack_states = @q.result(distinct: true)
      @objects = stack_states.page(@current_page)
      @total = stack_states.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to stack_states_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /stack_states/1
    def show
    end

    # GET /stack_states/new
    def new
      @stack_state = StackState.new
    end

    # GET /stack_states/1/edit
    def edit
    end

    # POST /stack_states
    def create
      @stack_state = StackState.new(stack_state_params)

      if @stack_state.save
        redirect(@stack_state, params)
      else
        render :new
      end
    end

    # PATCH/PUT /stack_states/1
    def update
      if @stack_state.update(stack_state_params)
        redirect(@stack_state, params)
      else
        render :edit
      end
    end

    def clone
      @stack_state = StackState.clone_record params[:stack_state_id]

      if @stack_state.save
        redirect_to admin_stack_states_path
      else
        render :new
      end
    end

    # DELETE /stack_states/1
    def destroy
      @stack_state.destroy
      redirect_to admin_stack_states_path, notice: actions_messages(@stack_state)
    end

    def destroy_multiple
      StackState.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_stack_states_path(page: @current_page, search: @query),
        notice: actions_messages(StackState.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_stack_state
      @stack_state = StackState.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stack_state_params
      params.require(:stack_state).permit(:name)
    end

    def show_history
      get_history(StackState)
    end
  end
end
