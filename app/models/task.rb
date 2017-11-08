# Task Model
class Task < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :phase
  belongs_to :project

  validates :phase_id,:number_hours,:price_bolivar,:cost_bolivar,:price_dolar,:cost_dolar, presence: { message: "Campos en blanco" }
  
  # Fields for the search form in the navbar
  def self.search_field
    :price_bolivar_or_price_dolar_or_cost_bolivar_or_cost_dolar_or_phase_id_cont
  end
end