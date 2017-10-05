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
   
    def history
      @order = Order.find(params[:order_id])
      @projects = Project.all
      @phases = Phase.all
      respond_to do |format|
        format.html
        format.json
        format.pdf {render template: 'admin/orders/history_pdf', pdf: 'Report_orders'}
      end
    end


    #Peticiones AJAX
    def project
      @project = Project.find(params[:project_id])
      @@count_bolivar = 0
      @@count_dolar = 0
      @project.phases.each do |phase|
        bolivar = phase.task.price_bolivar.to_f
        @@count_bolivar = @@count_bolivar + bolivar
        dolar = phase.task.price_dolar.to_f
        @@count_dolar = @@count_dolar + dolar
      end
    end   
     def payment_currency
      @payment_currency = (params[:payment_currency])
      @total_bolivar = @@count_bolivar 
      @total_dolar = @@count_dolar 
      $total_bolivar = @@count_bolivar 
      $total_dolar = @@count_dolar 
    end 
    def report_order   
      @order = Order.new
    end

    def search_report   
      $parametro = @order = Order.new(order_params)
      @orders = Order.all
    end
    
    # GET /orders/new
    def new
      @type_money = {}
      @order = Order.new
      @stack_client_name = Premium::Client.all.map {|obj| obj.nombre}
      @tasks = Task.all
      @Projects = Project.all
      @type_money = {USD:'1', VEF:'2'} 
    end

    # GET /orders/1/edit
    def edit
      @stack_states = StackState.all
    end

    # POST /orders
    def create
      @order = Order.new(order_params)
      @order.user_responsible = current_user.name
      @stack_state = StackState.all
      @order.stack_state_id = @stack_state = '1'
      if @order.payment_currency == "1"
        @order.price_project = $total_dolar
      elsif @order.payment_currency == "2"
        @order.payment_currency = $total_bolivar
      end
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
      params.require(:order).permit(:name_client, :identification_client, :phone_client, :email_client, :date_start_planned, :date_start_real, :date_end_planned, :date_end_real, :date_pause, :stack_state_id, :payment_currency, :price_project,:cost_project, :observations, :project_id)
    end

    def show_history
      get_history(Order)
    end
  end
end