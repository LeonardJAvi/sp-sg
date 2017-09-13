class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :price_bolivar
      t.string :price_dolar
      t.string :cost_bolivar
      t.string :cost_dolar
      t.string :phase_id

      t.timestamps null: false
    end
  end
end
