class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name_client
      t.string :identification_client
      t.string :phone_client
      t.string :email_client
      t.date :date_start_planned
      t.date :date_end_planned
      t.date :date_start_real
      t.date :date_end_real
      t.date :date_pause
      t.string :payment_currency
      t.float :price_project
      t.string :user_responsible
      t.string :project_id
      t.string :stack_state_id
      t.string :observation
      

      t.timestamps null: false
    end
  end
end
