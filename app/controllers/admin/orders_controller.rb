module Admin
  # OrdersController
  class OrdersController < AdminController
    before_action :set_order, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    before_action :phase_task_controller
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

    def phase_task_controller
    end
   
    def history
      @order = Order.find(params[:order_id])
      @projects = Project.all
      @phases = Phase.all
      respond_to do |format|
        format.html
        format.json
        format.pdf {render template: 'admin/orders/history_pdf', pdf: 'Report_orders', 
        tamaño_página: 'A4', font_size: '10px', layout: false, margin: {left: 0 , right: 0}  }
      end
    end

    def edition
      @order = Order.find(params[:order_id])
    end

    #Peticiones AJAX
    def project
      @project = Project.find(params[:project_id])
      @@cost_bolivar = 0
      @@cost_dolar = 0
      @@price_bolivar = 0
      @@price_dolar = 0
      @project.phases.each do |phase|
        
        price_bolivar = phase.task.price_bolivar.to_f
        cost_bolivar = phase.task.cost_bolivar.to_f
        price_dolar = phase.task.price_dolar.to_f
        cost_dolar = phase.task.cost_dolar.to_f

        @@price_bolivar = @@price_bolivar + price_bolivar 
        @@cost_bolivar = @@cost_bolivar + cost_bolivar
        @@price_dolar = @@price_dolar + price_dolar 
        @@cost_dolar = @@cost_dolar + cost_dolar
        
     
      
      end
    end   


    def payment_currency
      @payment_currency = (params[:payment_currency])
      @total_price_bolivar = @@price_bolivar 
      @total_cost_bolivar = @@cost_bolivar
      @total_price_dolar = @@price_dolar 
      @total_cost_dolar = @@cost_dolar

      $total_price_bolivar = @@price_bolivar 
      $total_cost_bolivar = @@cost_bolivar
      $total_price_dolar = @@price_dolar 
      $total_cost_dolar = @@cost_dolar

    end 

    def search_order   #report
      @order = Order.new
      respond_to do |format|
         format.html
         format.pdf {render template: 'admin/orders/pdf/report', pdf: 'Report_General',
         tamaño_pagina: 'A4', font_size: '10px', layout: false, margin: {left: 0, right: 0}}
       end
       $bandera = 0
    end

    def create_report
      @@bandera = 0
      $bandera = "1"
      $pdf = $bandera
      @orders = Order.all
      $parametro = @order = Order.new(order_params)
      redirect_to search_order_admin_orders_path
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
        @order.price_project = $total_price_dolar
        @order.cost_project = $total_cost_dolar
      elsif @order.payment_currency == "2"
        @order.price_project = $total_price_bolivar
        @order.cost_project = $total_cost_bolivar
      end
      @order.project.phases.each do |phase|
        if phase.task == nil
          @order.task = (false)
        end
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
        @order.project.phases.each do |phase|
          if phase.task == nil
            @order.task = (false)
          end
        end
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
      params.require(:order).permit(:name_client, :identification_client, :phone_client, :email_client, :date_start_planned, :date_start_real, :date_end_planned, :date_end_real, :date_pause,:date_notification, :stack_state_id, :payment_currency, :price_project,:cost_project, :observation, :cost_project, :person_contact, :email_contact, :phone_contact,:project_id)
    end

    def show_history
      get_history(Order)
    end
  end
end

