# Phase Model
class Phase < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :project
  has_one :task
  validates_associated :task
  validate :valid_phase
  validates :name,:project_id,:description, presence: { message: "There are blank fields." }
  validates :name, uniqueness: { message: "The name is already registered." }
  def valid_phase
    if self.project != nil
      self.project.phases.each do |phase|
        if phase.name == self.name
        errors.add(:project_id, "The name of the activity is registered to the selected project.") 
        end
      end
    end
  end
  # Fields for the search form in the navbar
  def self.search_field
    :name_or_description_or_project_id_cont
  end
end
