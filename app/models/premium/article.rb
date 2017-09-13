module Premium
  # Article Model
  class Article < ActiveRecord::Base
    establish_connection :premium_soft_development
    # validates_uniqueness_of :codigo, :cedula, :nrorif
    def self.table_name
      'articulo'
    end
  end
end