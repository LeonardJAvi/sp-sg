class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.float :number_hours
      t.float :price_bolivar
      t.float :price_dolar
      t.float :cost_bolivar
      t.float :cost_dolar
      t.float :phase_id

      t.timestamps null: false
    end
  end
end
