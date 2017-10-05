class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :group
      t.integer :notification_day

      t.timestamps null: false
    end
  end
end
