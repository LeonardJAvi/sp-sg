# StackState Model
class StackState < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :order
  belongs_to :historyorder

  #Field Validation
  validates :name,presence: { message: "Campos en blanco" }
  validates :name, uniqueness: { message: "El nombre ya se encuentra registrado" }

  
  # Fields for the search form in the navbar
  def self.search_field
    :name_cont
  end
end


