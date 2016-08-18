class AddBannerImageToTopics < ActiveRecord::Migration
  def change
    add_attachment :topics, :banner_image
  end
end
