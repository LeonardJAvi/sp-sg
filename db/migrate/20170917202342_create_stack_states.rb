class CreateStackStates < ActiveRecord::Migration
  def change
    create_table :stack_states do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
