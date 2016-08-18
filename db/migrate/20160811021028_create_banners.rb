class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.attachment :banner_image
      t.string :banner_title
      t.timestamps
    end
  end
end
