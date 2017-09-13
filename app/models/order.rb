# Order Model
class Order < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :project
  has_many :historyorders
  belongs_to :state
  after_create :order_history
  after_update :order_history

  def order_history
    Historyorder.create(name_client:self.name_client, identification_client:self.identification_client, phone_client:self.phone_client, email_client:self.email_client, date_start_planned:self.date_start_planned,
   date_start_real:self.date_start_real, date_end_planned:self.date_end_planned, date_end_real:self.date_end_real, date_pause:self.date_pause, state:self.state, payment_currency:self.payment_currency, 
   price_project:self.price_project, project_id:self.project_id, order_id:self.id, user_responsible:self.user_responsible, state_id:self.state_id)
  end

  # Fields for the search form in the navbar
  def self.search_field
    :name_client_or_identification_client_or_phone_client_or_email_client_or_date_start_planned_or_date_start_real_or_date_end_planned_or_date_end_real_or_date_pause_or_state_or_payment_currency_or_price_project_or_project_id_cont
  end
end



 

  