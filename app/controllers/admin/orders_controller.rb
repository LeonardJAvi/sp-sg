module Admin
  # OrdersController
  class OrdersController < AdminController
    before_action :set_order, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /orders
    def index
      @q = Order.ransack(params[:q])
      orders = @q.result(distinct: true)
      @objects = orders.page(@current_page)
      @total = orders.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to orders_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /orders/1
    def show
    end

    # GET /orders/new
    def new
      @order = Order.new
      @stack_client_name = Premium::Client.all.map {|obj| obj.nombre}
      @tasks = Task.all
      @Projects = Project.all
    end

    # GET /orders/1/edit
    def edit
    end

    # POST /orders
    def create
      @order = Order.new(order_params)
      @order.user_responsible = current_user.name
      @State = State.all
      @order.state_id = @state = '1'
      if @order.save
        redirect(@order, params)
      else
        render :new
      end
    end

    # PATCH/PUT /orders/1
    def update
      if @order.update(order_params)
        redirect(@order, params)
      else
        render :edit
      end
    end

    def clone
      @order = Order.clone_record params[:order_id]

      if @order.save
        redirect_to admin_orders_path
      else
        render :new
      end
    end

    # DELETE /orders/1
    def destroy
      @order.destroy
      redirect_to admin_orders_path, notice: actions_messages(@order)
    end

    def destroy_multiple
      Order.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_orders_path(page: @current_page, search: @query),
        notice: actions_messages(Order.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name_client, :identification_client, :phone_client, :email_client, :date_start_planned, :date_start_real, :date_end_planned, :date_end_real, :date_pause, :state, :payment_currency, :price_project,:cost_project, :project_id)
    end

    def show_history
      get_history(Order)
    end
  end
end








