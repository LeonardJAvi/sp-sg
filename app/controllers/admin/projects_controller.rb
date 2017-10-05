module Admin
  # ProjectsController
  class ProjectsController < AdminController
    before_action :set_project, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]

    # GET /projects
    def index
      @q = Project.ransack(params[:q])
      projects = @q.result(distinct: true)
      @objects = projects.page(@current_page)
      @total = projects.size
      if !@objects.first_page? && @objects.size.zero?
        redirect_to projects_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /projects/1
    def show
    end

    # GET /projects/new
    def new
      @project = Project.new  
      @list_project_name = Premium::Article.all.map {|obj| obj.nombre}
      @type_department = [ 'Dev', 'Social', 'Brand', 'Tech'] 
    end

    # GET /projects/1/edit
    def edit
      @list_project_name = Premium::Article.all.map {|obj| obj.nombre}
    end

    # POST /projects
    def create
      @project = Project.new(project_params)
      @stack_product=Premium::Article.all
      @stack_product.each do |articulo|
        if @project.name == articulo.nombre
           @project.group = articulo.grupo
        else
          puts "¡Error! create"
        end
      end
      
      if @project.save
        redirect(@project, params)
      else
        render :new
      end
    end

    # PATCH/PUT /projects/1
    def update

      if @project.update(project_params)
       
        redirect(@project, params)

         @stack_product=Premium::Article.all
        @stack_product.each do |articulo|
          if @project.name == articulo.nombre
             puts "esto es group antes #{@project.group}"
            @project.group = "00"
    
            puts "esto es group despues #{@project.group}"
          end
        end
      else
        render :edit
      end
    end

    def clone
      @project = Project.clone_record params[:project_id]

      if @project.save
        redirect_to admin_projects_path
      else
        render :new
      end
    end

    # DELETE /projects/1
    def destroy
      @project.destroy
      redirect_to admin_projects_path, notice: actions_messages(@project)
    end

    def destroy_multiple
      Project.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_projects_path(page: @current_page, search: @query),
        notice: actions_messages(Project.new)
      )
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :group, :department, :notification_day)
    end

    def show_history
      get_history(Project)
    end
  end
end
