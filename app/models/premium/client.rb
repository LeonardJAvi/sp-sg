module Premium
  # Client Model
  class Client < ActiveRecord::Base
    establish_connection :premium_soft_development
    # validates_uniqueness_of :codigo, :cedula, :nrorif
    def self.table_name
      'cliempre'
    end
  end
end
