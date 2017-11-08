# Project Model
class Project < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  has_many :phases
  has_many :orders
  has_many :tasks
 

  #Field Validation
  validates :name, presence: :true
  validates :name, uniqueness: { message: "El nombre ya se encuentra registrado" }

  
  # Fields for the search form in the navbar
  def self.search_field
    :name_or_group_cont
  end
end
