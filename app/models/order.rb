# Order Model
class Order < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :project
  has_many :historyorders
  belongs_to :stack_state
  after_create :order_history
  after_update :order_history
  validate :phase_task

  #validates :name_client,:identification_client,:phone_client,:email_client,:date_start_planned,:date_end_planned,:date_start_real,:date_end_real,:notification_day,:payment_currency,:price_project,:user_responsible,:project_id,:stack_state_id,:cost_project,:date_start_real,:person_contact,:email_contact,:phone_contact, presence: { message: "Campos en blanco" }
  

 
  def task=(value)
    @phase = value
  end

   def phase_task
    if self.project.phases == []
      errors.add(:project_id, "Estimado usuario, debe ingresar actividades y sus respectivas tareas") 
    elsif @phase == false
      errors.add(:project_id, "Estimado usuario, le falta una tarea a una actividad") 
    end
  end



  def order_history
    Historyorder.create(name_client:self.name_client, identification_client:self.identification_client, phone_client:self.phone_client, email_client:self.email_client, date_start_planned:self.date_start_planned,
   date_start_real:self.date_start_real, date_end_planned:self.date_end_planned, date_end_real:self.date_end_real, date_pause:self.date_pause, payment_currency:self.payment_currency, 
   price_project:self.price_project, project_id:self.project_id, order_id:self.id, user_responsible:self.user_responsible, stack_state_id:self.stack_state_id, observation:self.observation)
  end

  # Fields for the search form in the navbar
  def self.search_field
    :name_client_cont
  end
  def redirect(object, commit)
      if commit.key?('_save')
        @order.update(order_params)
        redirect_to admin_order_path(object), notice: actions_messages(object)
      elsif commit.key?('_add_other')
        redirect_to new_admin_order_path, notice: actions_messages(object)
      elsif commit.key?('_assing_rol')
        redirect_to admin_orders_path, notice: actions_messages(object)
      end
    end
end



