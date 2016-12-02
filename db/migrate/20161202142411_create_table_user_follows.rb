class CreateTableUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows, :id => false do |t|
      t.integer :user_id
      t.integer :follow_id
    end
  end
end
