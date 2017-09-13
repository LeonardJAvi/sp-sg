# Task Model
class Task < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :phase
  belongs_to :project

  # Fields for the search form in the navbar
  def self.search_field
    :price_bolivar_or_price_dolar_or_cost_bolivar_or_cost_dolar_or_phase_id_cont
  end
end
