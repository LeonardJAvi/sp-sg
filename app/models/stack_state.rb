# StackState Model
class StackState < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  belongs_to :order
  belongs_to :historyorder
  # Fields for the search form in the navbar
  def self.search_field
    :name_cont
  end
end


