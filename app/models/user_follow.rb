class UserFollow < ActiveRecord::Base
	## Relationships
	belongs_to :user
	belongs_to :follow, class_name: 'User'

	scope :check_following, -> (user_id,follow_id) { where('user_id = ? and follow_id = ?', user_id,follow_id) }
end
