class AddIndexToUserFollow < ActiveRecord::Migration
  def change
  	add_index :user_follows, :user_id
    add_index :user_follows, :follow_id
    add_index :user_follows, [:user_id, :follow_id], unique: true
  end
end
