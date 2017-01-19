class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
    add_column :users, :race, :string
    add_column :users, :marital_status, :string
    add_column :users, :zip, :string
  end
end
