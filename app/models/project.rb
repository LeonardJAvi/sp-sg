# Project Model
class Project < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  has_many :phases
  has_many :orders
  validates_associated :phases
  has_many :tasks


  # Fields for the search form in the navbar
  def self.search_field
    :name_or_group_cont
  end
end
