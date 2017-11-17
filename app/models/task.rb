# Task Model
class Task < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :phase
  belongs_to :project
  validate :cost_price
  validates :phase_id,:number_hours,:price_bolivar,:cost_bolivar,:price_dolar,:cost_dolar, presence: { message: "There are blank fields." }
  

  def cost_price
    if self.cost_bolivar != nil and self.cost_dolar != nil and self.price_bolivar != nil and self.price_dolar != nil
    	if self.price_bolivar < self.cost_bolivar 
    		errors.add(:price_bolivar.to_s, "Estimado usuario, el precio no puede ser menor que el costo") 
        end
        if self.price_dolar < self.cost_dolar 
    		errors.add(:price_dolar.to_s "Estimado usuario, el precio no puede ser menor que el costo") 
        end
    	if self.price_bolivar <= 0 
        	errors.add(:price_bolivar.to_s, "Estimado usuario, no se aceptan numeros negativos") 
        end
        if self.price_dolar <= 0 
        	errors.add(:price_dolar.to_s, "Estimado usuario, no se aceptan numeros negativos") 
        end
        if self.cost_bolivar <= 0 
        	errors.add(:cost_bolivar.to_s, "Estimado usuario, no se aceptan numeros negativos") 
        end
        if self.cost_dolar <= 0 
        	errors.add(:cost_dolar.to_s, "Estimado usuario, no se aceptan numeros negativos") 
        end
     
    end
  end



  # Fields for the search form in the navbar
  def self.search_field
    :price_bolivar_or_price_dolar_or_cost_bolivar_or_cost_dolar_or_phase_id_cont
  end
end