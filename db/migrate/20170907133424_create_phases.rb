class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.string :name
      t.string :description
      t.string :project_id

      t.timestamps null: false
    end
  end
end
