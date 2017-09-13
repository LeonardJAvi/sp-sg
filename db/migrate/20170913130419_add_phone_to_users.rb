class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :last_name, :string
    add_column :users, :identification, :string
    add_column :users, :birthdate, :date
  end
end
