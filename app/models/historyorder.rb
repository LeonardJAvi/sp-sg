class Historyorder < ActiveRecord::Base
	belongs_to :order
	belongs_to :state
end
