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
      t.date :date_notification
      t.string :payment_currency
      t.float :price_project
      t.string :user_responsible
      t.string :project_id
      t.string :stack_state_id
      t.string :observation
      t.float :cost_project
      t.string :person_contact
      t.string :email_contact
      t.string :phone_contact
      t.timestamps null: false
    end
  end
end
