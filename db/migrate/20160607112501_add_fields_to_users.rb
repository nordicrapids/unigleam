class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :age, :integer
    add_column :users, :address, :text
  end
end
