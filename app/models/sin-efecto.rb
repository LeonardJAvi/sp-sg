# History Order
class HistoryOrder < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :project
  belongs_to :order

  # Fields for the search form in the navbar
  def self.search_field
    :name_client_or_identification_client_or_phone_client_or_email_client_or_date_start_planned_or_date_start_real_or_date_end_planned_or_date_end_real_or_date_pause_or_state_or_payment_currency_or_price_project_or_project_id_cont
  end
end

