# Phase Model
class Phase < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :project
  has_one :task
  validates_associated :task

  # Fields for the search form in the navbar
  def self.search_field
    :name_or_description_or_project_id_cont
  end
end
