# StackState Model
class StackState < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :order
  belongs_to :historyorder

  #Field Validation
  validates :name, presence: { message: "There are blank fields." }
  validates :name, uniqueness: { message: "The name is already registered." }

  
  # Fields for the search form in the navbar
  def self.search_field
    :name_cont
  end
end


