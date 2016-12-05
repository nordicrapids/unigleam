class AddCreatedAtFieldToUserFollowTable < ActiveRecord::Migration
  def change
    add_column(:user_follows, :created_at, :datetime)
    add_column(:user_follows, :updated_at, :datetime)
  end
end
